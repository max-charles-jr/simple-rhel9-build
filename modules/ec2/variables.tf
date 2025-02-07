variable "instance_type" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "allow_public_ip_address" {
  type = bool
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "application_name" {
  type = string
}

variable "user_name" {
  type = string
}

variable "environment" {
  type = string
}
