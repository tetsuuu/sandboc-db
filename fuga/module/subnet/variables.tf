variable "service_vpc" {}
variable "cidr_block" {}
variable "environment" {}
variable "service_name" {}
variable "short_env" {}

locals {
  availability_zones = {
    "default" = "us-east-1a,us-east-1c"
  }
}
