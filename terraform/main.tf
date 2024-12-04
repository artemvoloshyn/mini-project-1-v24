module "vpc" {
  source                     = "./modules/vpc"
  cidr                       = var.cidr
  publicCIDR                 = var.publicCIDR
  environment                = var.environment
  availability_zone          = var.availability_zone
  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  allowed_ports              = var.allowed_ports
}

module "ec2" {
  source                    = "./modules/ec2"
  environment               = var.environment
  instance_type             = var.instance_type
  availability_zone         = var.availability_zone
  aws_vpc_security_group_id = [module.vpc.aws_vpc_security_group_id]
  aws_public_subnet_id      = module.vpc.aws_public_subnet_id
  depends_on                = [module.vpc]
}

module "s3" {
  source                         = "./modules/s3"
  aws_s3_bucket_name             = var.aws_s3_bucket_name
  index_html_source              = var.index_html_source
  config_json_source             = var.config_json_source
}

module "s3-policy" {
  source                         = "./modules/s3-policy"
  aws_s3_bucket_id               = module.s3.aws_s3_bucket_id
  aws_s3_bucket_arn              = module.s3.aws_s3_bucket_arn
  aws_user_account_id            = var.aws_user_account_id
  aws_cloudfront_distribution_id = module.cloudfront.aws_cloudfront_distribution_id
}


module "cloudfront" {
  source                             = "./modules/cloudfront"
  aws_s3_bucket_regional_domain_name = module.s3.aws_s3_bucket_regional_domain_name
  environment                        = var.environment
  whitelist_locations                = var.whitelist_locations
}