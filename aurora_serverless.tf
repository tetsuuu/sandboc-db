////resource "aws_db_subnet_group" "mysql-serverless" {
////  name        = "${var.service_name}-${var.short_env}-mysql-serverless"
////  description = "${var.service_name} db by serverless for load test"
////  subnet_ids  = "${aws_subnet.private.*.id}"
////
////  tags = {
////    Name         = "${var.service_name}-${var.environment}"
////    Envvironment = "${var.environment}"
////    Region       = "${var.region}"
////    Service      = "${var.service_name}"
////  }
////}
////
////resource "aws_rds_cluster" "service-db" {
////  cluster_identifier           = "${var.service_name}-${var.environment}"
////  engine                       = "${var.service_db["engine"]}"
////  engine_mode                  = "${var.service_db["engine_mode"]}"
////  engine_version               = "${var.service_db["engine_version"]}"
////  database_name                = "${var.service_name}${var.short_env}"
////  master_username              = "${var.service_db["user"]}"
////  master_password              = "${var.service_db["password"]}"
////  port                         = 3306
////  db_subnet_group_name         = "${aws_db_subnet_group.mysql-serverless.name}"
////  vpc_security_group_ids       = ["${aws_security_group.aurora-serverless.id}"]
////  storage_encrypted            = true
////  skip_final_snapshot          = "${var.environment == "develop" ? true : false}"
////  backup_retention_period      = 7
////  preferred_backup_window      = "${var.service_db["backup_window"]}"
////  preferred_maintenance_window = "${var.service_db["maintenance_window"]}"
////  apply_immediately            = true
////
////  //db_cluster_parameter_group_name = "${local.db_cluster_parameter_group_name}"
////
////  scaling_configuration {
////    auto_pause               = true
////    max_capacity             = "${var.service_db["maximum"]}"
////    min_capacity             = "${var.service_db["minimum"]}"
////    seconds_until_auto_pause = 300
////  }
////
////  lifecycle {
////    ignore_changes = ["engine_version"]
////  }
////
////  tags = {
////    Name         = "${var.service_name}-${var.environment}"
////    Envvironment = "${var.environment}"
////    Region       = "${var.region}"
////    Service      = "${var.service_name}"
////  }
////}
////
////resource "aws_security_group" "aurora-serverless" {
////  vpc_id      = aws_vpc.service-vpc.id
////  name        = "${format("%s-sg", var.service_name)}"
////  description = "${format("Security Group for %s", var.service_name)}"
////
////  ingress {
////    protocol    = "tcp"
////    from_port   = 3306
////    to_port     = 3306
////    cidr_blocks = ["${aws_vpc.service-vpc.cidr_block}"]
////  }
////
////  egress {
////    protocol    = "-1"
////    from_port   = 0
////    to_port     = 0
////    cidr_blocks = ["0.0.0.0/0"]
////  }
////
////  lifecycle {
////    create_before_destroy = true
////  }
////
////  tags = {
////    Name         = "${var.service_name}-${var.environment}"
////    Envvironment = "${var.environment}"
////    Region       = "${var.region}"
////    Service      = "${var.service_name}"
////  }
////}
////
/////* TODO arrenge later
////
////locals {
////  db_cluster_parameter_group_name = "${replace(var.service_db["engine_version"], "5.6.10a", "") != var.service_db["engine_version"] ? aws_rds_cluster_parameter_group.db-57.name : aws_rds_cluster_parameter_group.db-56.name}"
////}
////
////resource "aws_rds_cluster_parameter_group" "db-56" {
////  name   = "${var.service_name}-rds-cluster-my-56"
////  family = "aurora-serverless-5.6"
////
////  parameter {
////    name  = "log_autovacuum_min_duration"
////    value = "1"
////  }
////
////  # huge_pages is cluster_level_parameter and no-modifiable
////  parameter {
////    name  = "autovacuum_vacuum_cost_limit"
////    value = "400"
////  }
////}
////
////resource "aws_rds_cluster_parameter_group" "db-57" {
////  name   = "${var.service_name}-rds-cluster-my-57"
////  family = "aurora-mysql5.7"
////
////  # huge_pages is cluster_level_parameter and no-modifiable
////
////  parameter {
////    name  = "log_autovacuum_min_duration"
////    value = "1"
////  }
////  parameter {
////    name  = "autovacuum_vacuum_cost_limit"
////    value = "400"
////  }
////}
////*/
//
///* tfvars for aurora
//service_db = {
//  engine_version     = "5.6.10a"
//  instance_class     = "db.t2.small"
//  engine             = "aurora"
//  engine_mode        = "serverless"
//  db                 = "serverless-db"
//  user               = "dev_user"
//  password           = "sandbox0817"
//  backup_window      = "18:00-18:30"
//  maintenance_window = "sun:19:00-sun:19:30"
//  maximum            = 2
//  minimum            = 1
//}
//*/
