output "lambda_delete_arn" {
  value = "${aws_lambda_function.delete.invoke_arn}"
}
output "lambda_delete_name" {
  value = "${aws_lambda_function.delete.function_name}"
}