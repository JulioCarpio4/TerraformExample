data "archive_file" "lambda_post" {
  type        = "zip"
  source_dir  = "${path.module}/source_code"
  output_path = "${path.module}/lambda_post.zip"
}

resource "aws_lambda_function" "post" {
  filename         = "${data.archive_file.lambda_post.output_path}"
  function_name    = "${var.stack_name}-postPeople"
  role             = "${var.role_arn}"
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${filebase64sha256("${data.archive_file.lambda_post.output_path}")}"
  publish          = true
  timeout          = 5
}