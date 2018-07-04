variable "name" { }
variable "vpc_id" { }
variable "cidr_1" { }
variable "cidr_2" { }
variable "cidr_3" { }
variable "cidr_4" { }
variable "cidr_5" { }
variable "az_1" { }
variable "az_2" { }

# IGW
resource "aws_internet_gateway" "default" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table" "default" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "${var.name}"
  }
}

# public (Lambda, EC2)
resource "aws_subnet" "public_a" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_3}"
  availability_zone = "${var.az_1}"

  tags {
    Name = "${var.name}_public_a"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_4}"
  availability_zone = "${var.az_2}"

  tags {
    Name = "${var.name}_public_c"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "public_c" {
  subnet_id = "${aws_subnet.public_c.id}"
  route_table_id = "${aws_route_table.default.id}"
}

# private (RDS)
resource "aws_subnet" "private_a" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_1}"
  availability_zone = "${var.az_1}"

  tags {
    Name = "${var.name}_private_a"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr_2}"
  availability_zone = "${var.az_2}"

  tags {
    Name = "${var.name}_private_c"
  }
}

output "public_a_id" { value = "${aws_subnet.public_a.id}"}
output "public_c_id" { value = "${aws_subnet.public_c.id}"}
output "private_a_id" { value = "${aws_subnet.private_a.id}"}
output "private_c_id" { value = "${aws_subnet.private_c.id}"}
