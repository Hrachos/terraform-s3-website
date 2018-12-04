# Static S3 website deployment using Terraform

## Usage
* Create a tfvars file accordig to your needs, that populates variables defined in `variables.tf`
* run `terraform init`
* run `terraform plan -var-file my_vars.tfvars`
* run `terraform apply -var-file my_vars.tfvars`

## Caveats
On first run Cloudfront creates an ACM cert, which requires DNS validation. The required record to be created is dumped to the `domain_validation.txt` file.
Terraform should pass on the second run, should the first one fail.
