resource "aws_vpc" "service-vpc" {
  cidr_block           = "${lookup(local.vpc_cidr_blocks, var.region)}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name        = "${var.service_name}-${var.short_env}-vpc"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Service     = "${var.service_name}"
  }
}

resource "aws_subnet" "public" {
  count                   = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  vpc_id                  = "${aws_vpc.service-vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.service-vpc.cidr_block, 4, count.index + length(split(",", lookup(local.availability_zones, var.region))) * 0)}"
  availability_zone       = "${element(split(",", lookup(local.availability_zones, var.region)), count.index)}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_vpc.service-vpc"]

  tags = {
    Name        = "${var.service_name}-${var.short_env}-public-${count.index}"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Service     = "${var.service_name}"
  }
}

resource "aws_subnet" "private" {
  count                   = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  vpc_id                  = "${aws_vpc.service-vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.service-vpc.cidr_block, 4, count.index + length(split(",", lookup(local.availability_zones, var.region))) * 1)}"
  availability_zone       = "${element(split(",", lookup(local.availability_zones, var.region)), count.index)}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_vpc.service-vpc"]

  tags = {
    Name        = "${var.service_name}-${var.short_env}-private-${count.index}"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Service     = "${var.service_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.service-vpc.id}"

  tags = {
    Name        = "${var.service_name}-${var.short_env}-igw"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Service     = "${var.service_name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.service-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name        = "${var.service_name}-${var.short_env}-route-public"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Service     = "${var.service_name}"
  }
}

resource "aws_route_table" "private" {
  count  = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  vpc_id = "${aws_vpc.service-vpc.id}"

  tags = {
    Name        = "${var.service_name}-${var.short_env}-route-private"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Service     = "${var.service_name}"
  }
}

/* include NAT Gateway route table
resource "aws_route_table" "private" {
  count      = "${var.environment == "develop" ? 1 : "${length(split(",",lookup(local.availability_zones,var.region)))}"}"
  vpc_id     = "${aws_vpc.service-vpc.id}"
  //depends_on = ["aws_nat_gateway.admin"]

  route {
    cidr_block     = "${lookup(local.vpc_cidr_blocks, var.region)}"
    //nat_gateway_id = "${element(aws_nat_gateway.admin.*.id, count.index)}"
  }

  tags = {
    Name    = "${var.region}-${var.service_name}-route-private-${count.index}"
    Environment     = "${var.environment}"
    Region  = "${var.region}"
    Service = "${var.service_name}"
  }
}
*/

resource "aws_route_table_association" "public" {
  count          = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  depends_on     = ["aws_route_table.public", "aws_subnet.public"]
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  depends_on     = ["aws_route_table.private", "aws_subnet.private"]
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}

/* TODO arrenge later
resource "aws_eip" "developer" {
  count = "${var.environment == "develop" ? 1 : "${length(split(",", lookup(local.availability_zones, var.region)))}"}"
  vpc   = true

  tags = {
    Name         = "${var.region}-${var.service_name}-eip-consumer-${count.index}"
    Environment = "${var.environment}"
    Region       = "${var.region}"
    Service      = "${var.service_name}"
  }
}

resource "aws_eip" "admin" {
  count = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  vpc   = true

  tags = {
    Name         = "${var.region}-${var.service_name}-eip-admin-${count.index}"
    Environment = "${var.environment}"
    Region       = "${var.region}"
    Service      = "${var.service_name}"
  }
}

resource "aws_nat_gateway" "developer" {
  count         = "${var.environment == "develop" ? 1 : "${length(split(",", lookup(local.availability_zones, var.region)))}"}"
  depends_on    = ["aws_eip.developer", "aws_subnet.developer"]
  allocation_id = "${element(aws_eip.developer.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags = {
    Name         = "${var.region}-${var.service_name}-ngw-consumer-${count.index}"
    Environment = "${var.environment}"
    Region       = "${var.region}"
    Service      = "${var.service_name}"
  }
}

resource "aws_nat_gateway" "admin" {
  count         = "${var.environment == "develop" ? 1 : "${length(split(",", lookup(local.availability_zones, var.region)))}"}"
  depends_on    = ["aws_eip.admin", "aws_subnet.admin"]
  allocation_id = "${element(aws_eip.admin.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags = {
    Name         = "${var.region}-${var.service_name}-ngw-admin-${count.index}"
    Environment = "${var.environment}"
    Region       = "${var.region}"
    Service      = "${var.service_name}"
  }
}

resource "aws_route_table" "developer" {
  count      = "${var.environment == "develop" ? 1 : "${length(split(",", lookup(local.availability_zones, var.region)))}"}"
  vpc_id     = "${aws_vpc.service-vpc.id}"
  depends_on = ["aws_nat_gateway.developer"]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.developer.*.id, count.index)}"
  }

  tags = {
    Name         = "${var.region}-${var.service_name}-route-consumer-${count.index}"
    Environment = "${var.environment}"
    Region       = "${var.region}"
    Service      = "${var.service_name}"
  }
}

resource "aws_route_table" "admin" {
  count      = "${length(split(",", lookup(local.availability_zones, var.region)))}"
  vpc_id     = "${aws_vpc.service-vpc.id}"
  depends_on = ["aws_nat_gateway.admin"]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.admin.*.id, count.index)}"
  }

  tags = {
    Name         = "${var.region}-${var.service_name}-route-admin-${count.index}"
    Environment = "${var.environment}"
    Region       = "${var.region}"
    Service      = "${var.service_name}"
  }
}
*/
/*
resource "aws_flow_log" "vpc-flow-log" {
  count                = "${var.environment == "develop" ? 0 : 1}"
  depends_on           = ["aws_cloudwatch_log_group.vpc-flow-log-group", "aws_iam_role_policy_attachment.put-vpc-flow-log-policy-attach"]
  log_destination_type = "cloud-watch-logs"
  log_destination      = "${aws_cloudwatch_log_group.vpc-flow-log-group.arn}"
  iam_role_arn         = "${aws_iam_role.vpc-flow-log-role.arn}"
  vpc_id               = "${aws_vpc.service-vpc.id}"
  traffic_type         = "ALL"
}

resource "aws_cloudwatch_log_group" "vpc-flow-log-group" {
  count = "${var.environment == "develop" ? 0 : 1}"
  name  = "${var.region}-${var.service_name}-vpc-flow-log"
}

resource "aws_iam_role" "vpc-flow-log-role" {
  name = "${var.region}-${var.service_name}-vpc-flow-log-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "put-vpc-flow-log-policy" {
  name = "${var.region}-${var.service_name}-vpc-flow-log-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "put-vpc-flow-log-policy-attach" {
  depends_on = ["aws_iam_role.vpc-flow-log-role", "aws_iam_policy.put-vpc-flow-log-policy"]
  role       = "${aws_iam_role.vpc-flow-log-role.name}"
  policy_arn = "${aws_iam_policy.put-vpc-flow-log-policy.arn}"
}
*/
