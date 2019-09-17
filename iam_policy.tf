///*
//resource "aws_iam_policy" "read_s3_config" {
//  name = "${var.region}-ReadS3Config"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Sid": "AllowReadConfigBucket",
//      "Effect": "Allow",
//      "Action":[
//        "s3:Get*",
//        "s3:List*"
//      ],
//      "Resource":[
//        "arn:aws:s3:::${var.config_s3_bucket}",
//        "arn:aws:s3:::${var.config_s3_bucket}/*"
//      ]
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_policy" "readwrite_s3_config" {
//  name = "${var.region}-RWS3Config"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Sid": "AllowReadConfigBucket",
//      "Effect": "Allow",
//      "Action":[
//        "s3:Get*",
//        "s3:Put*",
//        "s3:List*"
//      ],
//      "Resource":[
//        "arn:aws:s3:::${var.config_s3_bucket}",
//        "arn:aws:s3:::${var.config_s3_bucket}/*"
//      ]
//    }
//  ]
//}
//EOF
//}
//*/
//
//resource "aws_iam_policy" "read_resource_s3_config" {
//  name = "${var.region}-ReadResourceS3Config"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Sid": "AllowReadConfigBucket",
//      "Effect": "Allow",
//      "Action":[
//        "s3:Get*",
//        "s3:List*"
//      ],
//      "Resource":[
//        "arn:aws:s3:::${var.resource_s3_bucket}",
//        "arn:aws:s3:::${var.resource_s3_bucket}/*"
//      ]
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_policy" "readwrite_resource_s3_config" {
//  name = "${var.region}-ReadWriteResourceS3Config"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Sid": "AllowReadWriteResourcecBucket",
//      "Effect": "Allow",
//      "Action":[
//        "s3:Get*",
//        "s3:Put*",
//        "s3:List*"
//      ],
//      "Resource":[
//        "arn:aws:s3:::${var.resource_s3_bucket}",
//        "arn:aws:s3:::${var.resource_s3_bucket}/*"
//      ]
//    }
//  ]
//}
//EOF
//}
//
//resource "aws_iam_policy" "allow_iam_maintenance_role" {
//  name = "${var.region}-AllowIamSet"
//
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Sid": "AllowReadConfigBucket",
//      "Effect": "Allow",
//      "Action": [
//        "iam:GetRole",
//        "iam:CreatePolicy",
//        "iam:CreateRole",
//        "iam:AttachRolePolicy",
//        "iam:PassRole",
//        "iam:RemoveRoleFromInstanceProfile",
//        "iam:DetachRolePolicy",
//        "iam:DeleteInstanceProfile",
//        "iam:DeletePolicy",
//        "iam:DeleteRole",
//        "iam:UpdateRoleDescription",
//        "iam:CreateInstanceProfile",
//        "iam:CreatePolicyVersion",
//        "iam:AddRoleToInstanceProfile",
//        "iam:DeletePolicyVersion",
//        "iam:UpdateAssumeRolePolicy",
//        "iam:PutRolePolicy",
//        "iam:DeleteRolePolicy"
//      ],
//      "Resource": "*"
//    }
//  ]
//}
//EOF
//}
