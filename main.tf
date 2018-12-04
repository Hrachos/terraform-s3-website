provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "${var.aws_profile}"
}

module "iam" {
  source       = "modules/iam"
  project_name = "${var.project_name}"
  bucket_name  = "${var.bucket_name}"
  environment  = "${var.environment}"
  region       = "${var.region}"
}

module "s3_bucket" {
  source      = "modules/bucket"
  bucket_name = "${var.bucket_name}"
  versioning  = "${var.versioning}"
}

module "cloudfront" {
  source          = "modules/cloudfront"
  bucket_name     = "${var.bucket_name}"
  allowed_methods = "${var.allowed_methods}"
  aws_profile     = "${var.aws_profile}"
}
