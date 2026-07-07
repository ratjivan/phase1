data "aws_iam_policy_document" "pipe_assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "pipes.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "pipe_role" {

  name = "${var.project_name}-${var.environment}-pipe-role"

  assume_role_policy = data.aws_iam_policy_document.pipe_assume_role.json

}



resource "aws_iam_policy" "pipe_policy" {

  name = "${var.project_name}-${var.environment}-pipe-policy"

  policy = jsonencode({

    Version = "2012-10-17",

    Statement = [

      {

        Effect = "Allow",

        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],

        Resource = var.queue_arn

      },

      {

        Effect = "Allow",

        Action = [
          "states:StartExecution"
        ],

        Resource = var.step_function_arn

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "attach" {

  role = aws_iam_role.pipe_role.name

  policy_arn = aws_iam_policy.pipe_policy.arn

}

resource "aws_pipes_pipe" "pipe" {

  name = "${var.project_name}-${var.environment}-pipe"

  role_arn = aws_iam_role.pipe_role.arn

  source = var.queue_arn

  target = var.step_function_arn

}