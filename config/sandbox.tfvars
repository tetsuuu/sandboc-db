region = "us-east-1"

service_name = "maintenance"

environment = "develop"

ec2_ami = "ami-035b3c7efe6d061d5" //"ami-1853ac65"

common_key = "sandbox-dev"
short_env  = "dev"

service_db = {
  engine_version     = "5.6.10a"
  instance_class     = "db.t2.small"
  engine             = "aurora"
  engine_mode        = "serverless"
  db                 = "serverless-db"
  user               = "dev_user"
  password           = "sandbox0817"
  backup_window      = "18:00-18:30"
  maintenance_window = "sun:19:00-sun:19:30"
  maximum            = 2
  minimum            = 1
}

admin_access_cidr_block = [
]
