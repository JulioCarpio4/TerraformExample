variable "table_name" {
  description = "Name of the DynamoDB table"
  default = "People"
}

variable "hash_key_name" {
  description = "Name of the attribute that will be used as hash_key in the table"
  default = "UserId"
}

variable "range_key_name" {
  description = "Name of the attribute that will be used as hash_key in the table"
  default     = "Country"
}