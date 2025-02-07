output "ami" {
  value = module.ec2.ami
}

output "public_dns" {
  value = module.ec2.public_dns
}

output "allow_public_ip_address" {
  value = module.ec2.public_ip
}

output "private_ip_address" {
  value = module.ec2.private_ip
}

output "availability_zone" {
  value = module.ec2.availability_zone
}

output "subnet_id" {
  value = module.ec2.subnet_id
}

output "iam_instance_profile_name" {
  value = module.ec2.iam_instance_profile
}

output "instance_id" {
  value = module.ec2.id
}

output "instance_type" {
  value = module.ec2.instance_type
}

output "security_group_ids" {
  value = module.ec2.vpc_security_group_ids
}

output "tags" {
  value = module.ec2.tags
}
