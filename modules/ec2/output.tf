output "ami" {
  value = aws_instance.web.ami
}

output "public_dns" {
  value = aws_instance.web.public_dns
}

output "allow_public_ip_address" {
  value = aws_instance.web.public_ip
}

output "private_ip_address" {
  value = aws_instance.web.private_ip
}

output "availability_zone" {
  value = aws_instance.web.availability_zone
}

output "subnet_id" {
  value = aws_instance.web.subnet_id
}

output "iam_instance_profile_name" {
  value = aws_instance.web.iam_instance_profile
}

output "instance_id" {
  value = aws_instance.web.id
}

output "instance_type" {
  value = aws_instance.web.instance_type
}

output "security_group_ids" {
  value = aws_instance.web.vpc_security_group_ids
}

output "tags" {
  value = aws_instance.web.tags
}
