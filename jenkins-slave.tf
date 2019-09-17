//resource "aws_instance" "jenkins-slave" {
//  count                  = "${contains(var.optional_resources, "jenkins_slave") ? var.jenkins_slave_count : 0}"
//  ami                    = "${var.ec2_ami}"
//  ebs_optimized          = false
//  instance_type          = "m5.large"
//  monitoring             = false
//  key_name               = "${var.common_key}"
//  subnet_id              = "${aws_subnet.public.0.id}"
//  vpc_security_group_ids = ["${aws_security_group.jenkins-slave-ingress.id}"]
//
//  //  associate_public_ip_address = false TODO tfbugs: always changed to true
//  associate_public_ip_address = true
//  source_dest_check           = true
//  iam_instance_profile        = "${aws_iam_instance_profile.jenkins.name}"
//
//  user_data = "${file("userdata/jenkins-slave.sh")}"
//
//  root_block_device {
//    volume_type           = "gp2"
//    volume_size           = "50"
//    delete_on_termination = "true"
//  }
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-jenkins-slave-${format("%02d", count.index +1)}"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//
//  lifecycle {
//    ignore_changes = [
//      "user_data",
//      "ami",
//      "instance_type",
//      "key_name",
//      "subnet_id",
//      "vpc_security_group_ids",
//      "ebs_optimized",
//    ]
//  }
//}
///*
//resource "aws_instance" "jenkins-slave-build" {
//  count                  = "${contains(var.optional_resources, "jenkins_slave_build") ? var.jenkins_slave_build_count : 0}"
//  ami                    = "${var.ec2_ami}"
//  ebs_optimized          = false
//  instance_type          = "m5.large"
//  monitoring             = false
//  key_name               = "${var.common_key}"
//  subnet_id              = "${aws_subnet.public.0.id}"
//  vpc_security_group_ids = ["${aws_security_group.jenkins-slave-ingress.id}"]
//
//  //  associate_public_ip_address = false TODO tfbugs: always changed to true
//  associate_public_ip_address = true
//  source_dest_check           = true
//  iam_instance_profile        = "jenkins-slave-build"
//
//  user_data = "${file("userdata/jenkins-slave-${var.environment}.sh")}"
//
//  root_block_device {
//    volume_type           = "gp2"
//    volume_size           = "100"
//    delete_on_termination = "false"
//  }
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-jenkins-slave-build-${format("%02d", count.index +1)}"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//
//  lifecycle {
//    ignore_changes = [
//      "user_data",
//      "ami",
//      "instance_type",
//      "key_name",
//      "root_block_device.0.volume_type",
//      "subnet_id",
//      "vpc_security_group_ids",
//      "ebs_optimized",
//    ]
//  }
//}
//*/
//
//resource "aws_security_group" "jenkins-slave-ingress" {
//  name        = "jenkins-slave-ingress"
//  description = "jenkins Slave Security Group"
//  vpc_id      = "${aws_vpc.service-vpc.id}"
//
//  ingress {
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = ["192.168.0.0/16"]
//  }
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-jenkins-ingress"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
