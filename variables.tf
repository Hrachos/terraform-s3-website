variable "aws_profile" {
  default = "default"
}

variable project_name {}

variable bucket_name {}

variable environment {
  default = "production"
}

variable "region" {
  default = "eu-central-1"
}

variable not-found-response-path {
  default = "/404.html"
}

variable "versioning" {
  default = false
}

variable "allowed_methods" {
  default = ["GET", "HEAD", "OPTIONS"]
}
