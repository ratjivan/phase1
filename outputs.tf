output "region" {
  value = var.aws_region
}

output "environment" {
  value = var.environment
}

output "project_name" {
  value = var.project_name
}

output "s3_bucket_name" {

  value = module.s3.bucket_name

}

output "s3_bucket_arn" {

  value = module.s3.bucket_arn

}

output "lambda_role_arn" {
  value = module.iam.lambda_role_arn
}

output "step_function_role_arn" {
  value = module.iam.step_role_arn
}

output "generate_lambda_arn" {

  value = module.generate_report_lambda.lambda_arn

}

output "notification_lambda_arn" {

  value = module.notification_lambda.lambda_arn

}

output "sqs_queue_url" {

  value = module.sqs.queue_url

}

output "sqs_queue_arn" {

  value = module.sqs.queue_arn

}

output "dlq_url" {

  value = module.sqs.dlq_url

}

output "dlq_arn" {

  value = module.sqs.dlq_arn

}

output "step_function_arn" {

  value = module.step_function.state_machine_arn

}

output "pipe_arn" {

  value = module.eventbridge_pipe.pipe_arn

}

output "api_gateway_url" {
  value = module.api_gateway.invoke_url
}

output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}
