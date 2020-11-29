variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "aws_profile" {
  type = string
  description = "AWS user profile"
}

variable "environment" {
  type = string
  description = "Environment name"
}

variable "iam_groups" {
  type    = list(string)
}
