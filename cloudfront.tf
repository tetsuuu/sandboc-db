

data "aws_route53_zone" "enphoto_root_zone" {
  name = "en-photo.net."
}

/*
resource "aws_route53_record" "cloudfront_pr03" {
  zone_id = "${data.aws_route53_zone.enphoto_root_zone.zone_id}"
  name    = "pr03"
  type    = "CNAME"
  ttl     = "300"
  records = ["enphoto-dev-pr-03.ap-northeast-1.elasticbeanstalk.com"] //after EB deploy
}
*/

resource "aws_route53_record" "cloudfront_pr03_thumbnail" {
  zone_id = "${data.aws_route53_zone.enphoto_root_zone.zone_id}"
  name    = "pr03-image"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_cloudfront_distribution.s3_distribution_pr03.domain_name}"]
}

resource "aws_cloudfront_distribution" "s3_distribution_pr03" {
  enabled             = true
  http_version        = "http2"
  is_ipv6_enabled     = true
  comment             = "${var.service_name} ${var.environment} thumbnail"
  aliases             = ["${var.pr03_thumbnail["domin_aliases"]}"]
  wait_for_deployment = true
  price_class         = "PriceClass_200"

  // customError 403
  custom_error_response {
    error_caching_min_ttl = 5
    error_code            = 403
    response_code         = 404
    response_page_path    = "/nophoto.png"
  }

  // customError 404
  custom_error_response {
    error_caching_min_ttl = 5
    error_code            = 404
    response_code         = 404
    response_page_path    = "/nophoto.png"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = false
    default_ttl            = 60
    min_ttl                = 1
    max_ttl                = 31536000
    smooth_streaming       = false
    target_origin_id       = "${var.pr03_thumbnail["s3_origin_id"]}" //"S3-enphoto-pr03/thumbnail"
    trusted_signers        = ["self"]
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }

    }
  }

  origin {
    domain_name = "${aws_s3_bucket.pr03.bucket_domain_name}"
    origin_id   = "${var.pr03_thumbnail["s3_origin_id"]}"
    origin_path = "${var.pr03_thumbnail["origin_path"]}"

    s3_origin_config {
      origin_access_identity = "${var.pr03_thumbnail["cloudfront_access_identity_path"]}"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:579663348364:certificate/4fabf5b0-7d57-4453-bb77-499a8db2bfe7"
    cloudfront_default_certificate = false
    iam_certificate_id             = ""
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }

  tags = {
    Name        = "${var.service_name}-pr03-cloudfront"
    Environment = "${var.environment}"
    Service     = "${var.service_name}"
  }
}
