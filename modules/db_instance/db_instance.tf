variable storage { }
variable engine { }
variable engine_version { }
variable instance_class { }
variable name { }
variable username { }
variable password { }
variable security_group_id { }
variable db_subnet_group_id { }

resource "aws_db_instance" "default" {
  allocated_storage = "${var.storage}"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  name = "${var.name}"
  username = "${var.username}"
  password = "${var.password}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  db_subnet_group_name   = "${var.db_subnet_group_id}"
}
