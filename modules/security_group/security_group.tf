variable name { }
variable description { }
variable vpc_id { }

resource "aws_security_group" "lambda" {
  name = "${var.name}_lambda"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "rds" {
  name = "${var.name}_rds"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    description = "${var.description}"
    security_groups = ["${aws_security_group.lambda.id}"]
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

  lifecycle {
    create_before_destroy = true
  }
}

output "rds_id" { value = "${aws_security_group.rds.id}"}
output "lambda_id" { value = "${aws_security_group.lambda.id}"}
