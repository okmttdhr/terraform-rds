variable "name" { }
variable "vpc_id" { }
variable "cidr_1" { }
variable "cidr_2" { }
variable "cidr_3" { }
variable "az_1" { }
variable "az_2" { }

resource "aws_subnet" "lambda_subnet" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_3}"
  availability_zone = "${var.az_1}"

  tags {
    Name = "${var.name}_lambda_subnet"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table" "lambda_subnet" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table_association" "lambda_subnet" {
  subnet_id = "${aws_subnet.lambda_subnet.id}"
  route_table_id = "${aws_route_table.lambda_subnet.id}"
}

resource "aws_subnet" "rds_subnet_1" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_1}"
  availability_zone = "${var.az_1}"

  tags {
    Name = "${var.name}_rds_subnet_1"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_2}"
  availability_zone = "${var.az_2}"

  tags {
    Name = "${var.name}_rds_subnet_2"
  }
}

output "lambda_subnet_id" { value = "${aws_subnet.lambda_subnet.id}"}
output "rds_subnet_1_id" { value = "${aws_subnet.rds_subnet_1.id}"}
output "rds_subnet_2_id" { value = "${aws_subnet.rds_subnet_2.id}"}
