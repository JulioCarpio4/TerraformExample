output "lambda_post_arn" {
  value = "${aws_lambda_function.post.invoke_arn}"
}
output "lambda_post_name" {
  value = "${aws_lambda_function.post.function_name}"
}