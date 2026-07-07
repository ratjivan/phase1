data "archive_file" "lambda_zip" {

  type = "zip"

  source_dir = var.lambda_source

  output_path = "${path.module}/${var.function_name}.zip"

}

resource "aws_cloudwatch_log_group" "lambda_logs" {

  name = "/aws/lambda/${var.function_name}"

  retention_in_days = 14

}

resource "aws_lambda_function" "lambda" {

  function_name = var.function_name

  filename = data.archive_file.lambda_zip.output_path

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role = var.role_arn

  handler = var.handler

  runtime = var.runtime

  timeout = 60

  memory_size = 256

  environment {

    variables = var.environment_variables

  }

  depends_on = [

    aws_cloudwatch_log_group.lambda_logs

  ]
}

