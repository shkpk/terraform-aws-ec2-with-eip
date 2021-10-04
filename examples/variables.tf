variable "region" {
  description = "AWS region name"
}

variable "environment" {
  description = "Name of the environment. Ex. Dev-2.0 "
}

variable "ssh_public_key" {
  description = "SSH public key to be setup"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}

variable "enable_eip" {
  description = "Enable or disable Elastic ip address"
}

variable "ami_owner" {
  description = "Owner ID of ami to be used"
}

variable "ami_filter_name" {
  description = "ami filter name"
}

variable "ami_filter_virtualization_type" {
  description = "ami filter virtualization type"
}


variable "vps_cidr" {
  description = "CIDR to be setup for VPC"
}


variable "availability_zones" {
  description = "List of availability zones"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of privatesubnets"
  default     = []
}

variable "ssh_port" {
  description = "ssh port"
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Whether to enable vpn gateway"
  type        = bool
  default     = false
}

variable "enable_second_nic" {
  description = "Whether to assign secondary network interface"
  type        = bool
  default     = false
}

variable "second_nic_subnet_id" {
  description = "The VPC Subnet ID to assign to secondary network interface"
  type        = string
  default     = null
}