variable "name" { }
variable "region" { }
variable "profile" { }

variable "az_1" { }
variable "az_2" { }

variable "vpc_cidr" { }

variable "sg_description" { }
variable "sg_cidrs" {
  type = "list"
}

variable "subnet_cidr_1" { }
variable "subnet_cidr_2" { }

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
  az_1 = "${var.az_1}"
  az_2 = "${var.az_2}"
}

module "security_group" {
  source = "./modules/security_group"

  name = "${var.name}"
  description = "${var.sg_description}"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs = ["${var.sg_cidrs}"]
}

module "db_subnet_group" {
  source = "./modules/db_subnet_group"

  name = "${var.name}"
  subnet_id_1 = "${module.subnet.subnet_1_id}"
  subnet_id_2 = "${module.subnet.subnet_2_id}"
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
  security_group_id = "${module.security_group.security_group_id}"
  db_subnet_group_id = "${module.db_subnet_group.db_subnet_group_id}"
}
