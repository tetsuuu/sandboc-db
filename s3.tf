/*
resource "aws_s3_bucket" "staging-image-bucket" {
  bucket = "${var.service_name}-${var.short_env}"
  region = "${var.region}"
  bucket_domain_name = "enphoto-stg.s3.amazonaws.com"
  bucket_regional_domain_name = "enphoto-stg.s3.ap-northeast-1.amazonaws.com"
  request_payer = "BucketOwner"


  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = [""]
    max_age_seconds = 3000
  }

  website {
    error_document = "error.html"
    index_document = "index.html"
    redirect_all_requests_to = ""
    routing_rules = ""
  }

  tags = {
    Name = "${var.service_name}-${var.short_env}-role"
    Environment = "${var.environment}"
    Service     = "${var.service_name}"
  }
}

resource "aws_s3_bucket_policy" "staging-image-bucket" {
  bucket = "${aws_s3_bucket.staging-image-bucket.id}"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity EQH4KPLGLS6Q5"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::enphoto-/*"
    }
  ]
}
EOF

  tags = {
    Name = "${var.service_name}-${var.short_env}-role"
    Environment = "${var.environment}"
    Service     = "${var.service_name}"
  }
}
*/

resource "aws_s3_bucket" "pr03" {
  bucket = "${var.service_name}-pr03"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  versioning {
    enabled    = false
    mfa_delete = false
  }

  website {
    error_document = "error.html"
    index_document = "index.html"
  }

  tags = {
    Name        = "${var.service_name}-${var.short_env}-bucket"
    Environment = "${var.environment}"
    Service     = "${var.service_name}"
  }
}

resource "aws_s3_bucket_policy" "pr03" {
  //depends_on = [aws_s3_bucket.pr03]
  bucket = "${aws_s3_bucket.pr03.id}"
  policy = jsonencode(
    {
      Id = "PolicyForCloudFrontPrivateContent"
      Statement = [
        {
          Action = "s3:GetObject"
          Effect = "Allow"
          Principal = {
            AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity EQH4KPLGLS6Q5"
          }
          Resource = "arn:aws:s3:::enphoto-pr03/*"
          Sid      = "1"
        },
      ]
      Version = "2008-10-17"
    }
  )
}
