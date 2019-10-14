resource "aws_subnet" "private" {
  count                   = length(split(",", lookup(local.availability_zones, "default")))
  vpc_id                  = var.service_vpc
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index + length(split(",", lookup(local.availability_zones, "default"))) * 1)
  availability_zone       = split(",", lookup(local.availability_zones, "default"))[count.index]
  map_public_ip_on_launch = false
  depends_on              = ["aws_vpc.service_vpc"]

  tags = {
    Name        = "${var.service_name}-${var.short_env}-sub-private-${count.index}"
    Environment = var.environment
    Service     = var.service_name
  }
}
