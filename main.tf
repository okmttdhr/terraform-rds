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

variable "rds_identifier" { }
variable "rds_storage" { }
variable "rds_engine" { }
variable "rds_engine_version" { }
variable "rds_instance_class" { }
variable "rds_username" { }
variable "rds_password" { }

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
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
  my_ip = "${module.vpc.sg_my_ip}"
  description_ec2 = "${var.sg_description_ec2}"
  description_rds = "${var.sg_description_rds}"
}

module "db_subnet_group" {
  source = "./modules/db_subnet_group"

  name = "${var.name}"
  subnet_id_1 = "${module.subnet.rds_subnet_1_id}"
  subnet_id_2 = "${module.subnet.rds_subnet_2_id}"
}

module "db_instance" {
  source = "./modules/db_instance"

  identifier = "${var.rds_identifier}"
  storage = "${var.rds_storage}"
  engine = "${var.rds_engine}"
  engine_version = "${var.rds_engine_version}"
  instance_class = "${var.rds_instance_class}"
  name = "${var.name}"
  username = "${var.rds_username}"
  password = "${var.rds_password}"
  security_group_id = "${module.security_group.rds_id}"
  db_subnet_group_id = "${module.db_subnet_group.db_subnet_group_id}"
}

module "ec2" {
  source = "./modules/ec2"

  name             = "${var.name}"
  ami              = "${var.ami}"
  ebs_optimized    = "${var.ebs_optimized}"
  monitoring       = "${var.monitoring}"
  key_name         = "${var.key_name}"
  public_key_path  = "${var.public_key_path}"
  subnet_id        = "${module.subnet.ec2_id}"
  sg_ids           = ["${module.security_group.ec2_id}"]
  nodes                       = "${var.nodes}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  source_dest_check           = "${var.source_dest_check}"
  volume_type                 = "${var.volume_type}"
  volume_size                 = "${var.volume_size}"
  delete_on_termination       = "${var.delete_on_termination}"
}
