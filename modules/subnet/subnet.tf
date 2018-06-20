variable "name" { }
variable "vpc_id" { }
variable "cidr_1" { }
variable "cidr_2" { }
variable "az_1" { }
variable "az_2" { }

resource "aws_subnet" "subnet_1" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_1}"
  availability_zone = "${var.az_1}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_2}"
  availability_zone = "${var.az_2}"

  tags {
    Name = "${var.name}"
  }
}

output "subnet_1_id" { value = "${aws_subnet.subnet_1.id}"}
output "subnet_2_id" { value = "${aws_subnet.subnet_2.id}"}
