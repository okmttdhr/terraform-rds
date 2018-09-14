variable cluster_identifier { }
variable engine { }
variable engine_mode { }
variable database_name { }
variable master_username { }
variable master_password { }
variable db_subnet_group_name { }
variable preferred_maintenance_window { }
variable preferred_backup_window { }
variable backup_retention_period { }
variable vpc_security_group_ids { }

resource "aws_rds_cluster" "default" {
  cluster_identifier            = "${var.cluster_identifier}"
  engine                        = "${var.engine}"
  engine_mode                   = "${var.engine_mode}"
  database_name                 = "${var.database_name}"
  master_username               = "${var.master_username}"
  master_password               = "${var.master_password}"
  backup_retention_period       = "${var.backup_retention_period}"
  preferred_backup_window       = "${var.preferred_backup_window}"
  preferred_maintenance_window  = "${var.preferred_maintenance_window}"
  db_subnet_group_name          = "${var.db_subnet_group_name}"
  vpc_security_group_ids        = ["${var.vpc_security_group_ids}"]
}
