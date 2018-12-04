output "DNS_validation_record" {
  value = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
}

output "DNS_validation_value" {
  value = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"
}
