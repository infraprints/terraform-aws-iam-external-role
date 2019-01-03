/*
arn - The Amazon Resource Name (ARN) specifying the role.
create_date - The creation date of the IAM role.
unique_id - The stable and unique string identifying the role.
name - The name of the role.
description - The description of the role.
*/

output "arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${aws_iam_role.external.arn}"
}

output "create_date" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${aws_iam_role.external.create_date}"
}

output "unique_id" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = "${aws_iam_role.external.unique_id}"
}

# output "name" {
#   description = "The Amazon Resource Name (ARN) specifying the role."
#   value       = "${aws_iam_role.external.arn}"
# }


# output "description" {
#   description = "The Amazon Resource Name (ARN) specifying the role."
#   value       = "${aws_iam_role.external.arn}"
# }

