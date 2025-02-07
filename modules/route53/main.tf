# Create an A record in Route 53 pointing to the EC2 instance's public IP
resource "aws_route53_record" "example" {
  zone_id = var.hosted_zone_id # Replace with your Route 53 Hosted Zone ID
  name    = var.dns_name       # Replace with your desired domain name
  type    = "A"
  ttl     = "300"
  records = var.instance_public_ip
}
