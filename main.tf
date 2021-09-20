resource "aws_instance" "this" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data_base64       = var.user_data_base64
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags                  = lookup(root_block_device.value, "tags", null)
    }
  }

  tags        = merge({ "Name" = var.name }, var.tags)
  volume_tags = var.enable_volume_tags ? merge({ "Name" = var.name }, var.volume_tags) : null
}

resource "aws_eip" "this" {

  count    = var.enable_eip ? 1 : 0
  instance = aws_instance.this.id
  vpc      = true

  tags = merge({ "Name" = "${var.name}-eip" }, var.tags)
}
