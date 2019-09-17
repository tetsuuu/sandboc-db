// enphoto staging variables
region = "ap-northeast-1"

environment = "staging"

service_name = "enphoto"

ec2_ami = ""  //TODO

maintenance_cidr_blocks = [
  "39.110.205.167/32"
]

delegate_domain = "en-photo.net."

max_capacity = 8

min_capacity = 4

common_key = "ennavi-photo-stg"

short_env = "stg"

backup_window = "13:11-13:41"

maintenance_window = "tue:18:45-tue:19:15"

db_user = "enphoto"

db_passwd = "enphoto"

private_sub = [
    "subnet-32480d44",
    "subnet-8d8e0ed5"
]

public_sub = [
    "subnet-93490ce5",
    "subnet-3f8e0e67"
]

target_vpc = "vpc-198d327d"

service_db = {
  engine_version     = "5.7.17"
  instance_class     = "db.t2.small"
  engine             = "mysql"
  user               = "enphoto"
  password           = "sandbox0817"
  storage            = 45
  backup_window      = "18:00-18:30"
  maintenance_window = "sun:19:00-sun:19:30"
}

//TODO
cf_thumbnail = {
  s3_origin_id                    = "enphoto-dev/spica-test-thumbnail"
  cloudfront_access_identity_path = "origin-access-identity/cloudfront/E3OIC1NJRUT25W"
  bucket_regional_domain_name     = "enphoto-dev.s3.amazonaws.com"
  domin_aliases                   = "dev-spica-image.en-photo.net"
  origin_path                     = "/spica-test-thumbnail"
}

pr03_thumbnail = {
  s3_origin_id                    = "S3-enphoto-pr03/thumbnail"
  cloudfront_access_identity_path = "origin-access-identity/cloudfront/EQH4KPLGLS6Q5"
  domin_aliases                   = "pr03-image.en-photo.net"
  origin_path                     = "/spica-test-thumbnail"
}
