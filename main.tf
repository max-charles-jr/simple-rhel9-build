terraform {
  cloud {

    organization = "max-charles-jr"

    workspaces {
      name = "rhel9_build"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}

module "ec2" {
  source = "./modules/ec2"

  instance_type             = "t3.medium"
  key_name                  = "mcc"
  iam_instance_profile_name = "mcharles-admin-role-ro"
  subnet_id                 = "subnet-0cbb9fdcb39ad7e4c"
  security_group_ids = [
    "sg-096eef053c80d5f7e"
  ]
  allow_public_ip_address = true
  volume_size             = 16
  volume_type             = "gp3"

  instance_name    = "rhel9-demo"
  application_name = "N/A"
  user_name        = "mcharles"
  environment      = "DEV"
}

module "lambda" {
  source = "./modules/lambda"

  instance_id = module.ec2.instance_id
}

module "route53" {
  source = "./modules/route53"

  dns_name           = "demo.maxcharlesjr.com"
  hosted_zone_id     = "ZSJJ5EJI2M7PK"
  instance_public_ip = module.ec2.public_ip_address
}
