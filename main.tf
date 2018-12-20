variable "name" { }
variable "region" { }
variable "profile" { }

variable "az_1" { }
variable "az_2" { }

variable "vpc_cidr" { }

variable "sg_my_ip" { }
variable "sg_description_rds" { }
variable "sg_description_ec2" { }

variable "subnet_cidr_1" { }
variable "subnet_cidr_2" { }
variable "subnet_cidr_3" { }
variable "subnet_cidr_4" { }
variable "subnet_cidr_5" { }

variable "rds_cluster_identifier" { }
variable "rds_engine" { }
variable "rds_engine_mode" { }
variable "rds_database_name" { }
variable "rds_master_username" { }
variable "rds_master_password" { }
variable "rds_preferred_maintenance_window" { }
variable "rds_preferred_backup_window" { }
variable "rds_backup_retention_period" { }

variable "ec2_ami" {}
variable "ec2_key_name" {}
variable "ec2_public_key_path" {}
variable "ec2_instance_type" {}
variable "ec2_associate_public_ip_address" {}
variable "ec2_volume_type" {}
variable "ec2_volume_size" {}
variable "ec2_delete_on_termination" {}
variable "eip_id" {}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
  version = "~> 1.33.0"
}

module "vpc" {
  source = "./modules/vpc"

  name = "${var.name}"
  cidr = "${var.vpc_cidr}"
}

module "subnet" {
  source = "./modules/subnet"

  name = "${var.name}"
  vpc_id = "${module.vpc.vpc_id}"
  cidr_1 = "${var.subnet_cidr_1}"
  cidr_2 = "${var.subnet_cidr_2}"
  cidr_3 = "${var.subnet_cidr_3}"
  cidr_4 = "${var.subnet_cidr_4}"
  cidr_5 = "${var.subnet_cidr_5}"
  az_1 = "${var.az_1}"
  az_2 = "${var.az_2}"
}

module "security_group" {
  source = "./modules/security_group"

  name = "${var.name}"
  vpc_id = "${module.vpc.vpc_id}"
  my_ip = "${var.sg_my_ip}"
  description_ec2 = "${var.sg_description_ec2}"
  description_rds = "${var.sg_description_rds}"
}

module "db_subnet_group" {
  source = "./modules/db_subnet_group"

  name = "${var.name}"
  subnet_id_1 = "${module.subnet.private_a_id}"
  subnet_id_2 = "${module.subnet.private_c_id}"
}

module "db_instance" {
  source = "./modules/db_instance"

  cluster_identifier            = "${var.rds_cluster_identifier}"
  engine                        = "${var.rds_engine}"
  engine_mode                   = "${var.rds_engine_mode}"
  database_name                 = "${var.rds_database_name}"
  master_username               = "${var.rds_master_username}"
  master_password               = "${var.rds_master_password}"
  backup_retention_period       = "${var.rds_backup_retention_period}"
  preferred_backup_window       = "${var.rds_preferred_backup_window}"
  preferred_maintenance_window  = "${var.rds_preferred_maintenance_window}"
  db_subnet_group_name          = "${module.db_subnet_group.db_subnet_group_id}"
  vpc_security_group_ids        = "${module.security_group.rds_id}"
}

module "ec2" {
  source = "./modules/ec2"

  name = "${var.name}"
  ami = "${var.ec2_ami}"
  key_name = "${var.ec2_key_name}"
  public_key_path = "${var.ec2_public_key_path}"
  subnet_id = "${module.subnet.public_a_id}"
  sg_ids = ["${module.security_group.ec2_id}"]
  instance_type = "${var.ec2_instance_type}"
  associate_public_ip_address = "${var.ec2_associate_public_ip_address}"
  volume_type = "${var.ec2_volume_type}"
  volume_size = "${var.ec2_volume_size}"
  delete_on_termination = "${var.ec2_delete_on_termination}"
  eip_id = "${var.eip_id}"
}

module "batch" {
  source = "./modules/batch"

  name = "${var.name}"
  subnet_id = "${module.subnet.public_a_id}"
  sg_ids = ["${module.security_group.lambda_id}"]
}
