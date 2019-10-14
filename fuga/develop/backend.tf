terraform {
  backend "s3" {
    bucket = "tk-infra-dev"
    key    = "terraform/poc/fuga/terraform.tfstate"
    region = "ue-seast-1"
  }
}
