terraform {
  required_version = "~> 0.12.5"
}

provider "aws" {
  region  = "${var.region}"
  version = "~> 2.14"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "environment" {
  default = "develop"
}

variable "service_name" {
  default = "enphoto"
}

variable "maintenance_cidr_blocks" {
  type    = "list"
  default = []
}

variable "private_sub" {
  type = "list"
  default = []
}

variable "public_sub" {
  type = "list"
  default = []
}

variable "service_db" {
  type    = "map"
  default = {}
}

//Cloudfront Setting

variable "pr03_thumbnail" {
  type    = "map"
  default = {}
}

variable "cf_thumbnail" {
  type    = "map"
  default = {}
}

variable "cf_zip" {
  type    = "map"
  default = {}
}

variable "cf_pdf" {
  type    = "map"
  default = {}
}

variable "target_vpc" {}
variable "ec2_ami" {}
variable "common_key" {}
variable "short_env" {}
variable "max_capacity" {}
variable "min_capacity" {}
variable "backup_window" {}
variable "maintenance_window" {}
variable "db_user" {}
variable "db_passwd" {}
variable "delegate_domain" {}

locals {
  vpc_cidr_blocks = {
    "ap-northeast-1" = "172.31.0.0/16"
    "us-east-1"      = "172.31.0.0/16"
    "ap-southeast-1" = "172.31.0.0/16"
    "eu-central-1"   = "172.31.0.0/16"
  }

  availability_zones = {
    "ap-northeast-1" = "ap-northeast-1a,ap-northeast-1c"
    "us-east-1"      = "us-east-1a,us-east-1c"
    "ap-southeast-1" = "ap-southeast-1a,ap-southeast-1b"
    "eu-central-1"   = "ec-central-1a,eu-central-1b"
  }
}
