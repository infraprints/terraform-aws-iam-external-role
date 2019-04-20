variable "name" {
  type        = "string"
  description = "The name of the role."
}

variable "description" {
  type        = "string"
  description = "The description of the role."
  default     = ""
}

variable "path" {
  type        = "string"
  description = "The path to the role. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) for more information."
  default     = "/external/"
}

variable "force_detach_policies" {
  type        = "string"
  description = "Specifies to force detaching any policies the role has before destroying it. Defaults to false."
  default     = true
}

variable "max_session_duration" {
  type        = "string"
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  default     = 3600
}

variable "permissions_boundary" {
  type        = "string"
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  default     = ""
}

variable "tags" {
  type        = "map"
  description = "Key-value mapping of tags for the IAM role."
  default     = {}
}

variable "external_id" {
  type        = "string"
  description = "External Identifier set on the role."
  default     = ""
}

variable "role_arn" {
  type        = "list"
  description = "The list of principal entities that is allowed to assume the role."
}

variable "count" {
  type        = "string"
  description = "The number of principal entities."
}
