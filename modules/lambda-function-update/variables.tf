variable "role_arn"{
  description = "ARN of the role that will be used by the lambda functions"
  type = "string"
}

variable "stack_name" {
  description = "Name of the aws stack"
  type = "string"
}