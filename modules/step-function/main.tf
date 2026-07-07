resource "aws_cloudwatch_log_group" "step_logs" {

  name = "/aws/vendedlogs/states/${var.project_name}"

  retention_in_days = 14

}

data "template_file" "definition" {

  template = file("${path.module}/workflow.json.tpl")

  vars = {

    notification_lambda = var.notification_lambda_arn

  }

}

resource "aws_sfn_state_machine" "state_machine" {

  name = "${var.project_name}-${var.environment}"

  role_arn = var.step_role_arn

  definition = data.template_file.definition.rendered

  logging_configuration {

    level = "ALL"

    include_execution_data = true

    log_destination = "${aws_cloudwatch_log_group.step_logs.arn}:*"

  }

}


