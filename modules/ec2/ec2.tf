variable "name" { }
variable "ami" { }
variable "key_name" { }
variable "public_key_path" { }
variable "subnet_id" { }
variable "sg_ids" {
  type = "list"
}
variable "instance_type" { }
variable "associate_public_ip_address" { }
variable "volume_type" { }
variable "volume_size" { }
variable "delete_on_termination" { }

resource "aws_key_pair" "default" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "default" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.default.key_name}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.sg_ids}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"

  root_block_device {
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  tags {
    "Name"    = "${var.name}"
  }
}

output "id" { value = ["${aws_instance.default.*.id}"] }
