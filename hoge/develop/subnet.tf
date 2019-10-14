module "pubric_subnet" {
  source = "../module/subnet"

  cidr_block = var.cidr_block
  environment = var.environment
  service_name = var.service_name
  service_vpc = var.service_vpc
  short_env = var.short_env
}
