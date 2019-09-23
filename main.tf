terraform {
  required_version = "0.12.5"
}

provider "aws" {
  region  = var.region
  version = "~> 2.14"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "environment" {}
variable "ec2_ami" {}
variable "common_key" {}
variable "short_env" {}
variable "delegate_domain" {}
variable "target_vpc" {}
variable "maintenance_cidr_blocks" {}

variable "service_db" {
  type    = "map"
  default = {}
}

variable "admin_access_cidr_block" {
  type    = "list"
  default = []
}

variable "optional_resources" {
  type    = "list"
  default = []
}

variable "service_name" {
  default = "maintenance"
}

// change cidr blocks
locals {
  vpc_cidr_blocks = {
    "ap-northeast-1" = "172.31.0.0/16"
    "us-east-1"      = "172.31.0.0/16"
    "ap-southeast-1" = "172.31.0.0/16"
    "us-west-2"      = "172.31.0.0/16"
  }

  availability_zones = {
    "ap-northeast-1" = "ap-northeast-1a,ap-northeast-1c"
    "us-east-1"      = "us-east-1a,us-east-1c"
    "ap-southeast-1" = "ap-southeast-1a,ap-southeast-1b"
    "us-west-2"      = "us-west-2a,us-west-2b"
  }
}

