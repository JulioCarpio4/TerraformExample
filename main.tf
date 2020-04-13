module "lambda-function-post" {
  source = "./modules/lambda-function-post"
  stack_name = "mainJC"
  role_arn   = "${module.role.lambda_role_arn}"
}

module "lambda-function-get" {
  source = "./modules/lambda-function-get"
  stack_name = "mainJC"
  role_arn   = "${module.role.lambda_role_arn}"
}

module "lambda-function-delete" {
  source = "./modules/lambda-function-delete"
  stack_name = "mainJC"
  role_arn   = "${module.role.lambda_role_arn}"
}

module "lambda-function-update" {
  source = "./modules/lambda-function-update"
  stack_name = "mainJC"
  role_arn   = "${module.role.lambda_role_arn}"
}

module "dynamoDb" {
  source = "./modules/dynamo"
}

module "role" {
    source = "./modules/role"
    stack_name = "mainJC"
    table_arn = "${module.dynamoDb.table_arn}"
}

module "apiGateway" {
  source = "./modules/api-gateway"
  lambda_get_arn = "${module.lambda-function-get.lambda_get_arn}"
  lambda_get_name = "${module.lambda-function-get.lambda_get_name}"
  lambda_post_arn = "${module.lambda-function-post.lambda_post_arn}"
  lambda_post_name = "${module.lambda-function-post.lambda_post_name}"
  lambda_delete_arn = "${module.lambda-function-delete.lambda_delete_arn}"
  lambda_delete_name = "${module.lambda-function-delete.lambda_delete_name}"
  lambda_update_arn = "${module.lambda-function-update.lambda_update_arn}"
  lambda_update_name = "${module.lambda-function-update.lambda_update_name}"
}


