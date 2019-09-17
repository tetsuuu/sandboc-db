region = "us-east-1"

service_name = "enphoto"

environment = "develop"

ec2_ami = "ami-035b3c7efe6d061d5" //"ami-1853ac65"

common_key = "mantenance_dev"
short_env  = "dev"
resource_s3_bucket = "uluru-enphoto-infra-tfstate"
admin_access_cidr_block = [
  "39.110.205.167/32",
  "118.103.95.42/32"
]

delegate_domain = "en-photo.net"

# mandatory resources are jenkins(master), bastion, ldap and nagios
optional_resources = [
  "jenkins_slave",
  "jenkins_slave_build",
]

jenkins_slave_count = 1

service_db = {
  engine_version     = "5.7.17"
  instance_class     = "db.t2.small"
  engine             = "mysql"
  name               = "enphoto"
  user               = "enphoto"
  password           = "sandbox0817"
  storage            = 20
  max_scale_storage  = 45
  backup_window      = "18:00-18:30"
  maintenance_window = "Sun:19:00-Sun:19:30"
}
