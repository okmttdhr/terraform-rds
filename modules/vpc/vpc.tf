variable "name" { }
variable "cidr" { }

resource "aws_vpc" "default" {
  name = "${var.name}"
  cidr_block = "${var.cidr}"
  tags {
    Name = "${var.name}"
  }
}

output "vpc_id" { value = "${aws_vpc.default.id}" }
output "vpc_cidr" { value = "${aws_vpc.default.cidr_block}" }
