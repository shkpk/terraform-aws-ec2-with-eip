output "ec2_public_ip" {
  value = module.ec2_single.public_ip
}

output "ec2_id" {
  value = module.ec2_single.id
}

output "arn" {
  description = "The ARN of the instance"
  value       = module.ec2_single.arn
}

output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = module.ec2_single.instance_state
}

output "outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value       = module.ec2_single.outpost_arn
}

output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = module.ec2_single.password_data
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = module.ec2_single.primary_network_interface_id
}

output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2_single.private_dns
}

output "public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.ec2_single.public_dns
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = module.ec2_single.tags_all
}

################################################################################
# EC2 Module - Output of multiple instances
################################################################################



output "ec2_multiple_public_ip" {
  value = {
    for k, v in module.ec2_multiple : k => v.public_ip
  }
}

output "ec2_multiple_id" {
  value = {
    for k, v in module.ec2_multiple : k => v.id
  }
}

output "ec2_multiple_arn" {
  description = "The ARN of the instance"
  value = {
    for k, v in module.ec2_multiple : k => v.arn
  }
}

output "ec2_multiple_instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value = {
    for k, v in module.ec2_multiple : k => v.instance_state
  }
}

output "ec2_multiple_outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value = {
    for k, v in module.ec2_multiple : k => v.outpost_arn
  }
}

output "ec2_multiple_password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value = {
    for k, v in module.ec2_multiple : k => v.password_data
  }
}

output "ec2_multiple_primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value = {
    for k, v in module.ec2_multiple : k => v.primary_network_interface_id
  }
}

output "ec2_multiple_private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value = {
    for k, v in module.ec2_multiple : k => v.private_dns
  }
}

output "ec2_multiple_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value = {
    for k, v in module.ec2_multiple : k => v.public_dns
  }
}

output "ec2_multiple_secondary_network_interface_id" {
  description = "The id of secondary network interface assigned to the instance, if applicable."
  value = {
    for k, v in module.ec2_multiple : k => v.secondary_network_interface_id
  }
}

output "ec2_multiple_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value = {
    for k, v in module.ec2_multiple : k => v.tags_all
  }
}