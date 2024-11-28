output "EC2_public_IP" {
  value     = module.ec2.associate_public_ip_address
}

output "CDN_URL" {
  value     = module.cloudfront.cloudfront_domain
}

output "CDN_ID" {
  value     = module.cloufront.id
}