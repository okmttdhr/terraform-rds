variable name { }
variable description { }
variable vpc_id { }
variable cidrs {
  type = "list"
}

resource "aws_security_group" "default" {
  name = "${var.name}"
  description = "${var.description}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.cidrs}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}"
  }
}

output "security_group_id" { value = "${aws_security_group.default.id}"}
