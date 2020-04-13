output "lambda_update_arn" {
  value = "${aws_lambda_function.update.invoke_arn}"
}
output "lambda_update_name" {
  value = "${aws_lambda_function.update.function_name}"
}