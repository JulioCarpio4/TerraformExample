data "archive_file" "lambda_delete" {
  type        = "zip"
  source_dir  = "${path.module}/source_code"
  output_path = "${path.module}/lambda_delete.zip"
}

resource "aws_lambda_function" "delete" {
  filename         = "${data.archive_file.lambda_delete.output_path}"
  function_name    = "${var.stack_name}-deletePeople"
  role             = "${var.role_arn}"
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${filebase64sha256("${data.archive_file.lambda_delete.output_path}")}"
  publish          = true
  timeout          = 5
}