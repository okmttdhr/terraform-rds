profile = "your-aws-profile"
name = "main"
region = "ap-northeast-1"

vpc_cidr = "10.0.0.0/16"

sg_name = "22_pxy"
sg_description = "Permit ssh from proxy server."
sg_cidrs = ["0.0.0.0/0"]

subnet_cidr_1 = "10.0.1.0/24"
subnet_cidr_2 = "10.0.2.0/24"
az_1 = "ap-northeast-1a"
az_2 = "ap-northeast-1c"

rds_storage = 100
rds_engine = "mysql"
rds_engine_version = "5.7.21"
rds_instance_class = "db.t2.medium"
rds_username = "root"
rds_password = "your-rds-password"
