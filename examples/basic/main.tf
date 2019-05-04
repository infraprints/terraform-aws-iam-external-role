resource "aws_iam_role" "default" {
  name        = "external-service-role"
  description = "A role in an external account."

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

  count = "1"
}

module "example" {
  source = "../../"

  name        = "externally-accessible-role"
  description = "The entrypoint to the AWS account from the external service account."
  role_arn    = "${local.externals}"
  count       = "${local.count}"
}
