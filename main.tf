variable "name" { }
variable "region" { }
variable "profile" { }

variable "az" { }
variable "vpc_cidr" { }

variable "sg_name" { }
variable "sg_description" { }
variable "sg_cidrs" {
  type = "list"
}

variable "subnet_cidr_1" { }
variable "subnet_cidr_2" { }
variable "az_1" { }
variable "az_2" { }

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

  name = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs = ["${var.sg_cidrs}"]
}

module "db_subnet_group" {
  source = "./modules/db_subnet_group"

  name = "${var.name}"
  subnet_id_1 = "${module.subnet.subnet_1.id}"
  subnet_id_2 = "${module.subnet.subnet_2.id}"
}

module "db_instance" {
  source = "./modules/db_instance"

  storage = "${var.}"
  engine = "${var.}"
  engine_version = "${var.}"
  instance_class = "${var.}"
  name = "${var.name}"
  username = "${var.}"
  password = "${var.}"
  security_group_id = "${module.security_group.default.id}"
  db_subnet_group_id = "${module.db_subnet_group.default.id}"
}
