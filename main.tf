data "aws_iam_policy_document" "external" {
  statement {
    sid     = "AllowExternalAccess"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.role_arn
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
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
      identifiers = var.role_arn
    }
  }
}

data "aws_arn" "external_role_arns" {
  count = var.count
  arn   = element(var.role_arn, count.index)
}

locals {
  account_ids = distinct(data.aws_arn.external_role_arns.*.account)

  tags = {
    IsExternal   = true
    AwsAccountID = join(",", local.account_ids)
    ExternalID   = var.external_id
  }
}

resource "aws_iam_role" "external" {
  name                  = var.name
  description           = var.description
  assume_role_policy    = var.external_id != "" ? data.aws_iam_policy_document.external.json : data.aws_iam_policy_document.aws.json
  path                  = var.path
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  force_detach_policies = var.force_detach_policies
  tags                  = merge(var.tags, local.tags)
}

