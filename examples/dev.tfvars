environment                    = "Dev-2.0"
region                         = "us-east-1"
availability_zones             = ["us-east-1a", "us-east-1b", "us-east-1c"]
ami_owner                      = "099720109477"
ami_filter_name                = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-*"
ami_filter_virtualization_type = "hvm"
# ssh_public_key                 = ""
vps_cidr                       = "10.0.0.0/16"
public_subnets                 = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
root_block_device = [
  {
    encrypted   = false
    volume_type = "gp3"
    volume_size = 10
  }
]
enable_eip    = true
instance_type = "t2.micro"
ssh_port      = 22