locals {
  roles = 5
}

resource "random_id" "unique" {
  count       = "${local.roles}"
  byte_length = 8
}

resource "aws_iam_role" "default" {
  count = "${local.roles}"
  name  = "acme-external-role-${count.index}-${element(random_id.unique.*.hex, count.index)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

module "example" {
  source = "../../"

  name              = "acme-assume-role-${random_string.name.result}"
  external_id       = "${random_string.external_id.result}"
  external_role_arn = ["${aws_iam_role.default.*.arn}"]
}

resource "random_string" "name" {
  length  = 16
  special = false
}

resource "random_string" "external_id" {
  length  = 16
  special = false
}
