data "aws_region" "current" {

}
data "aws_caller_identity" "current" {

}

resource "aws_api_gateway_rest_api" "APIGatewayJC" {
  name = "APIGatewayJC"
  description = "An API Gateway that will be used to invoke the related lambda functions depending the triggered http verb "
}

resource "aws_api_gateway_resource" "people" {
  rest_api_id = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  parent_id = "${aws_api_gateway_rest_api.APIGatewayJC.root_resource_id}"
  path_part = "people"
}

resource "aws_api_gateway_method" "method_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id   = "${aws_api_gateway_resource.people.id}"
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.userId" = true
  }
}

resource "aws_api_gateway_method" "method_post" {
  rest_api_id   = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id   = "${aws_api_gateway_resource.people.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "method_delete" {
  rest_api_id   = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id   = "${aws_api_gateway_resource.people.id}"
  http_method   = "DELETE"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.gameId" = true
  }
}

resource "aws_api_gateway_method" "method_update" {
  rest_api_id   = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id   = "${aws_api_gateway_resource.people.id}"
  http_method   = "PUT"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.userId" = true
  }
}

resource "aws_api_gateway_integration" "integration_get" {
  rest_api_id             = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id             = "${aws_api_gateway_resource.people.id}"
  http_method             = "${aws_api_gateway_method.method_get.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_get_arn}"
  request_parameters      = {
    "integration.request.path.userId" = "method.request.path.userId"
  }
}

resource "aws_api_gateway_integration" "integration_post" {
  rest_api_id             = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id             = "${aws_api_gateway_resource.people.id}"
  http_method             = "${aws_api_gateway_method.method_post.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_post_arn}"
}

resource "aws_api_gateway_integration" "integration_delete" {
  rest_api_id             = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id             = "${aws_api_gateway_resource.people.id}"
  http_method             = "${aws_api_gateway_method.method_delete.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_delete_arn}"
  request_parameters      = {
    "integration.request.path.gameId" = "method.request.path.gameId"
  }
}

resource "aws_api_gateway_integration" "integration_update" {
  rest_api_id             = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  resource_id             = "${aws_api_gateway_resource.people.id}"
  http_method             = "${aws_api_gateway_method.method_update.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_update_arn}"
  request_parameters      = {
    "integration.request.path.userId" = "method.request.path.userId"
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [ aws_api_gateway_integration.integration_delete,
                 aws_api_gateway_integration.integration_get, 
                 aws_api_gateway_integration.integration_post, 
                 aws_api_gateway_integration.integration_update ]
  rest_api_id = "${aws_api_gateway_rest_api.APIGatewayJC.id}"
  stage_name  = "test"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "apigw_lambda_get" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_get_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.APIGatewayJC.id}/*/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_post" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_post_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.APIGatewayJC.id}/*/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_delete" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_delete_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.APIGatewayJC.id}/*/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_update" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_update_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.APIGatewayJC.id}/*/*/*"
}