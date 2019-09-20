//resource "aws_db_instance" "service-db" {
//  identifier                   = "${var.service_name}-${var.short_env}-db"
//  allocated_storage            = "${var.service_db["storage"]}"
//  max_allocated_storage        = "${var.service_db["max_scale_storage"]}"
//  storage_type                 = "gp2"
//  engine                       = "${var.service_db["engine"]}"
//  engine_version               = "${var.service_db["engine_version"]}"
//  instance_class               = "${var.service_db["instance_class"]}"
//  name                         = "${var.service_db["name"]}"
//  username                     = "${var.service_db["user"]}"
//  password                     = "${var.service_db["password"]}"
//  db_subnet_group_name         = "${aws_db_subnet_group.service-db.name}"
//  port                         = 3306
//  parameter_group_name         = "default.mysql5.7"
//  backup_retention_period      = 7
//  backup_window                = "${var.service_db["backup_window"]}"
//  maintenance_window           = "${var.service_db["maintenance_window"]}" //stg "mon:18:21-mon:18:51"
//  auto_minor_version_upgrade   = false
//  //performance_insights_enabled = true
//  deletion_protection          = "${var.environment == "develop" ? false : true}"
//  apply_immediately            = true
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-rds"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
//
//resource "aws_security_group" "service-db-sg" {
//  vpc_id      = "${aws_vpc.service-vpc.id}"
//  name        = "${var.service_name}-${var.short_env}-mysql-rds"
//  description = "${var.service_name} ${var.environment} RDS MySQL Security Group"
//
//  ingress {
//    protocol    = "tcp"
//    from_port   = 3306
//    to_port     = 3306
//    cidr_blocks = ["${lookup(local.vpc_cidr_blocks, var.region)}"]
//  }
//
//  egress {
//    protocol    = "-1"
//    from_port   = 0
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-mysql-rds"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
//
//resource "aws_security_group_rule" "allow_local" {
//  count             = "${var.environment == "develop" ? 1 : 0}"
//  type              = "ingress"
//  from_port         = 3306
//  to_port           = 3306
//  protocol          = "tcp"
//  cidr_blocks       = "${var.admin_access_cidr_block}"
//  security_group_id = "${aws_security_group.service-db-sg.id}"
//}
//
//resource "aws_db_subnet_group" "service-db" {
//  name        = "${var.service_name}-${var.short_env}-mysql-rds"
//  description = "${var.service_name} db subnet for ${var.environment}"
//  subnet_ids  = "${var.environment == "develop" ? "${aws_subnet.public.*.id}" : "${aws_subnet.private.*.id}"}"
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-vpc"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
