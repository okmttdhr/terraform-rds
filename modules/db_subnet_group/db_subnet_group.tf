variable name { }
variable subnet_id_1 { }
variable subnet_id_2 { }

resource "aws_db_subnet_group" "default" {
  name = "${var.name}"
  subnet_ids = ["${var.subnet_id_1}", "${var.subnet_id_2}"]

  tags {
    Name = "${var.name}"
  }
}
