output "lambda_get_arn" {
  value = "${aws_lambda_function.get.invoke_arn}"
}
output "lambda_get_name" {
  value = "${aws_lambda_function.get.function_name}"
}