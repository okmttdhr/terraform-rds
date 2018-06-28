variable "name"                        { }
variable "ami"                         { }
variable "ebs_optimized"               { }
variable "instance_type"               { }
variable "monitoring"                  { }
variable "key_name"                    { }
variable "public_key_path"             { }
variable "subnet_id"                   { }
variable "sg_ids"                      {
  type = "list"
}
variable "nodes"                       { }
variable "associate_public_ip_address" { }
variable "source_dest_check"           { }
variable "volume_type"                 { }
variable "volume_size"                 { }
variable "delete_on_termination"       { }

resource "aws_key_pair" "tf-key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "default" {
  ami                         = "${var.ami}"
  ebs_optimized               = "${var.ebs_optimized}"
  instance_type               = "${var.instance_type}"
  monitoring                  = "${var.monitoring}"
  key_name                    = "${aws_key_pair.tf-key.key_name}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.sg_ids}"]
  count                       = "${var.nodes}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  source_dest_check           = "${var.source_dest_check}"

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
