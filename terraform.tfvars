profile = "mmm"
name = "aws_billing"
region = "ap-northeast-1"
version = "1.33.0"

az_1 = "ap-northeast-1a"
az_2 = "ap-northeast-1c"

vpc_cidr = "10.0.0.0/16"

sg_my_ip = "54.64.44.206/32"
sg_description_rds = "Permit access from the security group of Lambda."
sg_description_ec2 = "Permit access from your custom IP"

subnet_cidr_1 = "10.0.1.0/24"
subnet_cidr_2 = "10.0.2.0/24"
subnet_cidr_3 = "10.0.3.0/24"
subnet_cidr_4 = "10.0.4.0/24"
subnet_cidr_5 = "10.0.5.0/24"

rds_cluster_identifier = "aws-billing"
rds_storage = 100
rds_engine = "aurora"
rds_database_name = "aws_billing"
rds_engine_version = "5.7.12"
rds_engine_version = "5.7.12"
rds_engine_mode = "serverless"
rds_instance_class = "db.t2.micro"
rds_storage_type = "gp2"
rds_master_username = "root"
rds_master_password = ""
rds_backup_retention_period = "7"
rds_preferred_backup_window = "19:00-20:00"
rds_preferred_maintenance_window = "Mon:17:00-Mon:18:00"

ec2_ami = "ami-e99f4896" // Amazon Linux 2 AMI (HVM), SSD Volume Type
ec2_key_name = "tf-key"
ec2_public_key_path = "~/.ssh/tf-key.pub"
ec2_instance_type = "t2.micro"
ec2_associate_public_ip_address = "true"
ec2_volume_type = "standard"
ec2_volume_size = "50"
ec2_delete_on_termination = "false"
eip_id = "eipalloc-8514b5e0"
