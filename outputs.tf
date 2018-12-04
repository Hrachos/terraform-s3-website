output "user_access_key_id" {
  value = "${module.iam.user_access_key_id}"
}

output "user_access_key_secret" {
  value = "${module.iam.user_access_key_secret}"
}

output "DNS_validation_record" {
  value = "${module.cloudfront.DNS_validation_record}"
}

output "DNS_validation_value" {
  value = "${module.cloudfront.DNS_validation_value}"
}
