
output "table_id" {
  value = "${aws_dynamodb_table.dynamodb-table-JC.id}"
}

output "table_arn" {
  value = "${aws_dynamodb_table.dynamodb-table-JC.arn}"
}

output "table_name" {
    value = "${aws_dynamodb_table.dynamodb-table-JC.name}"
}

output "hash_key_name" {
    value = ""
}

output "range_key_name" {
    value = ""
}