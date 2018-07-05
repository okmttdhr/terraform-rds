variable identifier { }
variable storage { }
variable engine { }
variable engine_version { }
variable instance_class { }
variable storage_type { }
variable name { }
variable username { }
variable password { }
variable security_group_id { }
variable db_subnet_group_id { }
variable maintenance_window { }
variable backup_window { }
variable backup_retention_period { }

resource "aws_db_instance" "default" {
  identifier = "${var.identifier}"
  allocated_storage = "${var.storage}"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  storage_type = "${var.storage_type}"
  name = "${var.name}"
  username = "${var.username}"
  password = "${var.password}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  db_subnet_group_name = "${var.db_subnet_group_id}"
  publicly_accessible = true
  maintenance_window = "${var.maintenance_window}"
  backup_window = "${var.backup_window}"
  backup_retention_period = "${var.backup_retention_period}"
}
