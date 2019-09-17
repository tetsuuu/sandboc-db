/*
resource "aws_instance" "bastion" {
  ami                         = "${var.ec2_ami}"
  ebs_optimized               = false
  instance_type               = "t3.micro"
  monitoring                  = false
  key_name                    = "${var.common_key}"
  subnet_id                   = "${aws_subnet.public.0.id}"
  vpc_security_group_ids      = ["${aws_security_group.bastion-v2.id}"]
  associate_public_ip_address = true
  source_dest_check           = true
  iam_instance_profile        = "${var.region}-bastion-v2"

  user_data = "${data.template_file.userdata-bastion-v2.rendered}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = false
  }

  tags {
    "Name"    = "${var.region}-bastion-v2"
    "Service" = "maintenance"
    "Segment" = "public"
    "Role"    = "bastion"
    "Brand"   = "fr"
    "Env"     = "${var.environment}"
    "Country" = "gl"
    "Cost"    = "Cost:maintenance:${var.environment}:fr:gl"
  }

  volume_tags {
    "Name"    = "${var.region}-bastion-v2"
    "Service" = "maintenance"
    "Segment" = "public"
    "Role"    = "bastion"
    "Brand"   = "fr"
    "Env"     = "${var.environment}"
    "Country" = "gl"
    "Cost"    = "Cost:maintenance:${var.environment}:fr:gl"
  }

  lifecycle {
    ignore_changes = [
      "user_data",
      "ami",
      "instance_type",
      "key_name",
      "root_block_device.0.volume_type",
      "subnet_id",
      "vpc_security_group_ids",
      "ebs_optimized",
    ]
  }
}
*/
