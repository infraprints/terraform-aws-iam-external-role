locals {
  ## WORKAROUND: Specify count instead of length(local.externals)
  roles = 5
}

resource "aws_iam_role" "default" {
  count = "${local.roles}"
  name  = "infraprints-iam-external-role-multiple-assume-${count.index}"

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

  name        = "infraprints-iam-external-role-multiple"
  external_id = "${random_string.external_id.result}"
  role_arn    = "${local.externals}"
  count       = "${local.roles}"
}

resource "random_string" "external_id" {
  length  = 16
  special = false
}
