resource "aws_iam_role" "default" {
  name = "infraprints-iam-external-role-assume-role"

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

  ## WORKAROUND: Specify count instead of length(local.externals)
  count = "1"
}

module "example" {
  source = "../../"

  name     = "infraprints-iam-external-role-basic"
  role_arn = "${local.externals}"
  count    = "${local.count}"
}
