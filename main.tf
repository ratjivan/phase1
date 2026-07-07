module "s3" {

  source = "./modules/s3"

  bucket_name = var.bucket_name

  environment = var.environment

  project_name = var.project_name

}

module "iam" {

  source = "./modules/iam"

  project_name = var.project_name

  environment = var.environment
  
}
module "sqs" {

  source = "./modules/sqs"

  project_name = var.project_name

  environment = var.environment

}

module "generate_report_lambda" {

  source = "./modules/lambda"

  function_name = "generate-report"

  lambda_source = "./lambda/generate-report"

  role_arn = module.iam.lambda_role_arn

  environment_variables = {

    QUEUE_URL = module.sqs.queue_url

  }

}

module "notification_lambda" {

  source = "./modules/lambda"

  function_name = "notification"

  lambda_source = "./lambda/notification"

  role_arn = module.iam.lambda_role_arn

  environment_variables = {

    BUCKET_NAME = module.s3.bucket_name

  }

}

module "step_function" {

  source = "./modules/step-function"

  project_name = var.project_name

  environment = var.environment

  step_role_arn = module.iam.step_role_arn

  notification_lambda_arn = module.notification_lambda.lambda_arn

  bucket_name = module.s3.bucket_name

}

module "eventbridge_pipe" {

  source = "./modules/eventbridge-pipe"

  project_name = var.project_name

  environment = var.environment

  queue_arn = module.sqs.queue_arn

  step_function_arn = module.step_function.state_machine_arn

}

module "api_gateway" {

  source = "./modules/api-gateway"

  project_name = var.project_name

  environment = var.environment

  lambda_invoke_arn = module.generate_report_lambda.lambda_invoke_arn

  lambda_function_name = module.generate_report_lambda.lambda_name

}