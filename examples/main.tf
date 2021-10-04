provider "aws" {
  region = local.region
}

locals {
  name   = var.environment
  region = var.region

  user_data = <<-EOT
  #!/bin/bash
  echo "Hello World!"
  EOT

  tags = {
    Owner       = "user"
    Environment = var.environment
  }
}

data "aws_ami" "ec2_ami" {
  owners      = [var.ami_owner]
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_filter_name]
  }
  filter {
    name   = "virtualization-type"
    values = [var.ami_filter_virtualization_type]
  }

}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = "${local.name}-ssh-key"
  public_key = var.ssh_public_key

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.name}-vpc"
  cidr = var.vps_cidr

  azs = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Name        = "${local.name}-vpc"
  }
}

module "ssh_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-ssh-sg"
  description = "Security group for SSH Port"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.vps_cidr]
  egress_rules        = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      description = "SSH port ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

################################################################################
# EC2 Module
################################################################################


module "ec2_single" {
  source = "../"

  name = local.name

  ami                    = data.aws_ami.ec2_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_ssh_key.key_name
  availability_zone      = element(module.vpc.azs, 0)
  subnet_id              = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids = [module.ssh_sg.security_group_id]
  user_data_base64       = base64encode(local.user_data)
  enable_volume_tags     = false
  root_block_device      = var.root_block_device
  enable_eip             = var.enable_eip

  tags = local.tags
}



################################################################################
# EC2 Module - multiple instances with `for_each`
################################################################################


locals {
  multiple_instances = {
    one = {
      instance_type     = "t3.micro"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.public_subnets, 0)
      enable_eip        = true
      enable_second_nic = true
      second_nic_subnet_id = element(module.vpc.public_subnets, 1)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          throughput  = 200
          volume_size = 50
          tags = {
            Name = "my-root-block"
          }
        }
      ]
    }
    two = {
      instance_type     = "t3.small"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.public_subnets, 1)
      enable_eip        = true
      enable_second_nic = false
    #   second_nic_subnet_id = element(module.vpc.public_subnets, 0)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp2"
          volume_size = 50
        }
      ]
    }
    three = {
      instance_type     = "t3.medium"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.public_subnets, 1)
      enable_eip        = false
      enable_second_nic = false
    #   second_nic_subnet_id = element(module.vpc.public_subnets, 0)
    }
  }
}

module "ec2_multiple" {
  source = "../"

  for_each = local.multiple_instances

  name = "${local.name}-multi-${each.key}"

  ami                    = data.aws_ami.ec2_ami.id
  instance_type          = each.value.instance_type
  key_name               = aws_key_pair.ec2_ssh_key.key_name
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [module.ssh_sg.security_group_id]
  user_data_base64       = base64encode(local.user_data)
  #   enable_volume_tags = false
  #   root_block_device  = each.value.root_block_device
  enable_eip = each.value.enable_eip
  enable_second_nic = each.value.enable_second_nic
  second_nic_subnet_id = each.value.enable_second_nic ? each.value.second_nic_subnet_id : null

  enable_volume_tags = false
  root_block_device  = lookup(each.value, "root_block_device", [])

  tags = local.tags
}
