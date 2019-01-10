data "aws_iam_policy_document" "external" {
  statement {
    sid     = "AllowExternalAccess"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.external_role_arn}"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["${var.external_id}"]
    }
  }
}

data "aws_iam_policy_document" "aws" {
  statement {
    sid     = "AllowExternalAccess"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.external_role_arn}"]
    }
  }
}

# data "aws_arn" "external_role_arns" {
#   count = "${length(var.external_role_arn)}"
#   arn   = "${element(var.external_role_arn, count.index)}"
# }

locals {
  #account_ids = "${distinct(data.aws_arn.external_role_arns.*.account)}"

  tags = {
    IsExternal = true

    #ExternalIDs = "${join(",", local.account_ids)}"
  }
}

resource "aws_iam_role" "external" {
  name               = "${var.name}"
  assume_role_policy = "${var.external_id != "" ? data.aws_iam_policy_document.external.json : data.aws_iam_policy_document.aws.json}"
  #assume_role_policy = "${data.aws_iam_policy_document.external.json}"

  tags = "${merge(var.tags, local.tags)}"
}
