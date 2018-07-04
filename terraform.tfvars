profile = "your-aws-profile"
name = "main"
region = "ap-northeast-1"

az_1 = "ap-northeast-1a"
az_2 = "ap-northeast-1c"

vpc_cidr = "10.0.0.0/16"

sg_my_ip = "0.0.0.0/0"
sg_description_rds = "Permit access from the security group of Lambda."
sg_description_ec2 = "Permit access from your custom IP"

subnet_cidr_1 = "10.0.1.0/24"
subnet_cidr_2 = "10.0.2.0/24"
subnet_cidr_3 = "10.0.3.0/24"
subnet_cidr_4 = "10.0.4.0/24"
subnet_cidr_5 = "10.0.5.0/24"

rds_identifier = "your_rds_identifier"
rds_storage = 100
rds_engine = "mysql"
rds_engine_version = "5.7.21"
rds_instance_class = "db.t2.micro"
rds_storage_type = "gp2"
rds_username = "root"
rds_password = "your-rds-password"
rds_maintenance_window = "Mon:17:00-Mon:18:00"
rds_backup_window = "19:00-20:00"
rds_backup_retention_period = "7"

ec2_ami = "ami-e99f4896" // Amazon Linux 2 AMI (HVM), SSD Volume Type
ec2_key_name = "tf-key"
ec2_public_key_path = "~/.ssh/tf-key.pub"
ec2_instance_type = "t2.micro"
ec2_associate_public_ip_address = "true"
ec2_volume_type = "standard"
ec2_volume_size = "50"
ec2_delete_on_termination = "false"
eip_id = "eipalloc-"
