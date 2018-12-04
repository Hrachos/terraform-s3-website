provider "aws" {
  region = "us-east-1"
  alias = "useast1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "${var.aws_profile}"
}

resource "aws_acm_certificate" "cert" {
  domain_name = "${var.bucket_name}"
  validation_method = "DNS"
  provider = "aws.useast1"
  provisioner "local-exec" {
    command = <<EOT
    echo ${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name} > domain_validation.txt &&
    echo ${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value} >> domain_validation.txt
EOT
  }
}


resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  provider = "aws.useast1"
}

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled      = true
  http_version = "http2"

  "origin" {
    origin_id   = "${var.bucket_name}"
    domain_name = "${var.bucket_name}"

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = "${var.allowed_methods}"
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.bucket_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.cert.arn}"
    ssl_support_method = "sni-only"
  }
}
