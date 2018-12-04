resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled = "${var.versioning}"
  }
}

locals {
  s3_origin_id = "${var.bucket_name}"
}
