locals {
  roles = 5
}

resource "aws_iam_role" "default" {
  count = "${local.roles}"
  name  = "external-service-role-${count.index}"

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

locals {
  externals = ["${aws_iam_role.default.*.arn}"]
}

module "example" {
  source = "../../"

  name        = "externally-accessible-role"
  external_id = "${random_string.external_id.result}"
  role_arn    = "${local.externals}"
  count       = "${local.roles}"
}

resource "random_string" "external_id" {
  length  = 16
  special = false
}
