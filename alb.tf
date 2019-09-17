//resource "aws_alb" "maintenance-alb" {
//  idle_timeout    = 60
//  internal        = false
//  name            = "maintenance-alb"
//  security_groups = ["${aws_security_group.alb.id}"]
//  subnets         = "${aws_subnet.public.*.id}"
//
//  enable_deletion_protection = false
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-maintenance-alb"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
//
//resource "aws_security_group" "alb" {
//  name        = "maintenance-alb"
//  description = "Security grup for maintenance LB"
//  vpc_id      = "${aws_vpc.service-vpc.id}"
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-maintenance-alb-ingress"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
//
//resource "aws_security_group_rule" "maintenance-alb-ingress-443" {
//  depends_on        = ["aws_security_group.alb"]
//  type              = "ingress"
//  from_port         = 443
//  to_port           = 443
//  protocol          = "tcp"
//  security_group_id = "${aws_security_group.alb.id}"
//  cidr_blocks = "${var.admin_access_cidr_block}"
//}
//
//resource "aws_security_group_rule" "maintenance-alb-ingress-80" {
//  depends_on        = ["aws_security_group.alb"]
//  type              = "ingress"
//  from_port         = 80
//  to_port           = 80
//  protocol          = "tcp"
//  security_group_id = "${aws_security_group.alb.id}"
//
//  cidr_blocks = "${var.admin_access_cidr_block}"
//}
//
//resource "aws_alb_target_group" "jenkins" {
//  name     = "jenkins"
//  port     = 8080
//  protocol = "HTTP"
//  vpc_id   = "${aws_vpc.service-vpc.id}"
//
//  health_check {
//    matcher = "200,403"
//  }
//}
//
//resource "aws_alb_listener" "jenkins" {
//  depends_on        = ["aws_alb.maintenance-alb", "aws_acm_certificate_validation.jenkins"]
//  load_balancer_arn = "${aws_alb.maintenance-alb.id}"
//  port              = "443"
//  protocol          = "HTTPS"
//  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
//  certificate_arn   = "${aws_acm_certificate_validation.jenkins.certificate_arn}"
//
//  default_action {
//    target_group_arn = "${aws_alb_target_group.jenkins.id}"
//    type             = "forward"
//  }
//}
//
//data "aws_route53_zone" "root_zone" {
//  name = "${var.delegate_domain}."
//}
//
//resource "aws_route53_record" "jenkins" {
//  zone_id = "${data.aws_route53_zone.root_zone.zone_id}"
//  name    = "jenkins.${var.region}.${var.delegate_domain}"
//  type    = "A"
//
//  alias {
//    name                   = "${aws_alb.maintenance-alb.dns_name}"
//    zone_id                = "${aws_alb.maintenance-alb.zone_id}"
//    evaluate_target_health = true
//  }
//
//  lifecycle {
//    create_before_destroy = true
//  }
//}
//
//resource "aws_acm_certificate" "jenkins" {
//  domain_name       = "${aws_route53_record.jenkins.fqdn}"
//  validation_method = "DNS"
//
//  lifecycle {
//    create_before_destroy = true
//  }
//
//  tags = {
//    Name         = "${var.service_name}-${var.short_env}-jenkins"
//    Envvironment = "${var.environment}"
//    Region       = "${var.region}"
//    Service      = "${var.service_name}"
//  }
//}
//
//resource "aws_route53_record" "cert-dns-validate-record-jenkins" {
//  depends_on = ["aws_acm_certificate.jenkins"]
//  name       = "${aws_acm_certificate.jenkins.domain_validation_options.0.resource_record_name}"
//  type       = "${aws_acm_certificate.jenkins.domain_validation_options.0.resource_record_type}"
//  zone_id    = "${data.aws_route53_zone.root_zone.zone_id}"
//  records    = ["${aws_acm_certificate.jenkins.domain_validation_options.0.resource_record_value}"]
//  ttl        = 60
//
//  lifecycle {
//    create_before_destroy = true
//  }
//}
//
//resource "aws_acm_certificate_validation" "jenkins" {
//  depends_on              = ["aws_route53_record.cert-dns-validate-record-jenkins", "aws_acm_certificate.jenkins"]
//  certificate_arn         = "${aws_acm_certificate.jenkins.arn}"
//  validation_record_fqdns = ["${aws_route53_record.cert-dns-validate-record-jenkins.fqdn}"]
//
//  lifecycle {
//    create_before_destroy = true
//  }
//}
