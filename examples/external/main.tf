resource "aws_iam_role" "default" {
  name = "external-service-role"

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
  externals = ["${aws_iam_role.default.arn}"]
  count     = "1"
}

module "example" {
  source = "../../"

  name        = "externally-accessible-role"
  external_id = "${random_string.external_id.result}"
  role_arn    = "${local.externals}"
  count       = "${local.count}"
}

resource "random_string" "external_id" {
  length  = 16
  special = false
}
