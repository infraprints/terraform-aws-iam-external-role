# AWS IAM External Role

Terraform module for describing an IAM role responsible for delegating cross-account access.

These types of resources are supported:

- [IAM Role](https://www.terraform.io/docs/providers/aws/r/iam_role.html)

## Usage

```hcl
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
```

## Examples

- [Basic Example](examples/basic)
- [Adjusted Example](examples/adjusted)

## Notes

- With the default configuration, all objects in the S3 bucket will **expire** in 90 days.
- The S3 bucket uses tiered storage with eventual expiration. This bucket is not designed for long term persistence.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| count | The number of principal entities. | string | n/a | yes |
| description | The description of the role. | string | `""` | no |
| external\_id | External Identifier set on the role. | string | `""` | no |
| force\_detach\_policies | Specifies to force detaching any policies the role has before destroying it. Defaults to false. | string | `"true"` | no |
| max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | string | `"3600"` | no |
| name | The name of the role. | string | n/a | yes |
| path | The path to the role. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) for more information. | string | `"/external/"` | no |
| permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the role. | string | `""` | no |
| role\_arn | The list of principal entities that is allowed to assume the role. | list | n/a | yes |
| tags | Key-value mapping of tags for the IAM role. | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role. |
| create\_date | The Amazon Resource Name (ARN) specifying the role. |
| unique\_id | The Amazon Resource Name (ARN) specifying the role. |
