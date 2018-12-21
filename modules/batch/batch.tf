variable "sg_ids" {
  type = "list"
}
variable "subnet_id" { }
variable "name" { }

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.name}_ecs_instance_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "default" {
  name  = "${var.name}_aws_iam_instance_profile"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role" "aws_batch_service_role" {
  name  = "${var.name}_aws_batch_service_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "batch.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = "${aws_iam_role.aws_batch_service_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_iam_role" "ec2_spot_fleet_role" {
  name  = "${var.name}_ec2_spot_fleet_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "spotfleet.amazonaws.com"
      }
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "ec2_spot_fleet_role" {
  role       = "${aws_iam_role.ec2_spot_fleet_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetRole"
}

resource "aws_batch_compute_environment" "default" {
  compute_environment_name = "${var.name}"
  compute_resources {
    instance_role = "${aws_iam_instance_profile.default.arn}"
    instance_type = [
      "m3.medium",
    ]
    desired_vcpus = 1
    max_vcpus = 1
    min_vcpus = 0
    security_group_ids = [
      "${var.sg_ids}"
    ]
    subnets = [
      "${var.subnet_id}"
    ]
    bid_percentage = 50
    spot_iam_fleet_role = "${aws_iam_role.ec2_spot_fleet_role.arn}"
    type = "SPOT"
  }
  service_role = "${aws_iam_role.aws_batch_service_role.arn}"
  type = "MANAGED"
  depends_on = ["aws_iam_role_policy_attachment.aws_batch_service_role"]
}

# テスト用。ジョブ定義は別リポジトリで作成する。
resource "aws_batch_job_definition" "default" {
    name = "${var.name}_test"
    type = "container"
    container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["ls", "-la"],
    "image": "busybox",
    "memory": 1024,
    "vcpus": 1,
    "volumes": [
      {
        "host": {
          "sourcePath": "/tmp"
        },
        "name": "tmp"
      }
    ],
    "environment": [
        {"name": "VARNAME", "value": "VARVAL"}
    ],
    "mountPoints": [
        {
          "sourceVolume": "tmp",
          "containerPath": "/tmp",
          "readOnly": false
        }
    ],
    "ulimits": [
      {
        "hardLimit": 1024,
        "name": "nofile",
        "softLimit": 1024
      }
    ]
}
CONTAINER_PROPERTIES
}

resource "aws_batch_job_queue" "default" {
  name = "${var.name}"
  state = "ENABLED"
  priority = 1
  compute_environments = ["${aws_batch_compute_environment.default.arn}"]
  
  lifecycle {
    create_before_destroy = true
  }
}
