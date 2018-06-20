variable "name"                        { }
variable "region"                      { }
variable "profile"                     { }

variable "az"                          { }
variable "vpc_cidr"                    { }
variable "subnet_cidr"                 { }

variable "sg_name"                     { }
variable "sg_description"              { }
variable "sg_cidrs"                    {
  type = "list"
}

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

  name   = "${var.name}"
  vpc_id = "${module.vpc.vpc_id}"
  cidr   = "${var.subnet_cidr}"
  az     = "${var.az}"
}

module "security_group" {
  source = "./modules/security_group"

  name        = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = ["${var.sg_cidrs}"]
}

resource "db_instance" "default" {
  depends_on             = ["aws_security_group.default"]
  identifier             = "${var.identifier}"
  allocated_storage      = "${var.storage}"
  engine                 = "${var.engine}"
  engine_version         = "${lookup(var.engine_version, var.engine)}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.name}"
  username               = "${var.username}"
  password               = "${var.password}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.default.id}"
}
