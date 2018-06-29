variable "name" { }
variable "cidr" { }

resource "aws_vpc" "default" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.name}"
  }
}

output "vpc_id" { value = "${aws_vpc.default.id}" }
output "vpc_cidr" { value = "${aws_vpc.default.cidr_block}" }
