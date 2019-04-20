module "example" {
  source = "git::https://gitlab.com/infraprints/modules/aws/iam-external-role"

  name        = "infraprints-iam-external-role"
  external_id = "TXAiS9rfgQghzWW2"
  role_arn    = ["${aws_iam_role.default.arn}"]
  count       = "1"
}

resource "aws_iam_role" "default" {
  name = "infraprints-ec2-role"

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
