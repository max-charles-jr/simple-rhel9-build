data "aws_ami" "rhel_9" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9.*.*_HVM-*-x86_64-0-*-GP3"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["309956199498"]
}
