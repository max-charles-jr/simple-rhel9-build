resource "aws_instance" "web" {
  ami           = data.aws_ami.rhel_9.id
  instance_type = var.instance_type

  iam_instance_profile = var.iam_instance_profile_name

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.allow_public_ip_address

  user_data = templatefile("${path.module}/provision.sh")

  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type

    tags = {
      Name        = var.instance_name
      Application = var.application_name
      CreatedBy   = var.user_name
      Environment = var.environment
    }
  }

  tags = {
    Name        = var.instance_name
    Application = var.application_name
    CreatedBy   = var.user_name
    Environment = var.environment
  }
}

