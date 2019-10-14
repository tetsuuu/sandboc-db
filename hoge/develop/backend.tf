terraform {
  backend "s3" {
    bucket = "tk-infra-dev"
    key    = "terraform/poc/hoge/terraform.tfstate"
    region = "ue-seast-1"
  }
}
