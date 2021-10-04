environment                    = "Dev-2.0"
region                         = "us-east-1"
availability_zones             = ["us-east-1a"]
ami_owner                      = "099720109477"
ami_filter_name                = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-*"
ami_filter_virtualization_type = "hvm"
ssh_public_key                 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuOxD61hCUKb0/mLSnlMeqzMO28IlFt+v1SRKephzk/20hRaTblDMD1RuBC7ceqsJcrTjBufBz1BAzNTnlLAKZy1NvBJKf9IwaM7qNe1FXtd5NLzKNk8XUjNoSbplmXJAa+HIaVyd+tW1AHSSn62l00+8V39OnJxriCaM01qW3m0TxggwBbHrXqRD7JOc6QfdM1eCtXIo2o3QuE+4r2jwNUHGx7Fp06ad0h38hW+f03gV0G1iGbZJy4/LcfanyDKE+8SS6pYQ4SQMqG8ehmMRx2TlBFybE1xJd+ZXEqKi7b0GbMx5DXxld9GjgynjDkHKBYevHxUIzJl4qReL8CDG5"
vps_cidr                       = "10.0.0.0/16"
public_subnets                 = ["10.0.101.0/24", "10.0.102.0/24"]
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
