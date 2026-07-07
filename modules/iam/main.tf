#########################################
# Lambda Assume Role Policy
#########################################

data "aws_iam_policy_document" "lambda_assume_role" {

  statement {

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#########################################
# Lambda IAM Role
#########################################

resource "aws_iam_role" "lambda_role" {

  name = "${var.project_name}-${var.environment}-lambda-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

#########################################
# Lambda IAM Policy
#########################################

resource "aws_iam_policy" "lambda_policy" {

  name = "${var.project_name}-${var.environment}-lambda-policy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = "*"
      }

    ]
  })
}

#########################################
# Lambda Policy Attachment
#########################################

resource "aws_iam_role_policy_attachment" "lambda_attach" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_policy.arn
}

#########################################
# Step Function Assume Role
#########################################

data "aws_iam_policy_document" "step_assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "states.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}

#########################################
# Step Function Role
#########################################

resource "aws_iam_role" "step_role" {

  name = "${var.project_name}-${var.environment}-step-role"

  assume_role_policy = data.aws_iam_policy_document.step_assume_role.json
}

#########################################
# Step Function Policy
#########################################
resource "aws_iam_policy" "step_policy" {

  name = "${var.project_name}-${var.environment}-step-policy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "lambda:InvokeFunction"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogDelivery",
          "logs:GetLogDelivery",
          "logs:UpdateLogDelivery",
          "logs:DeleteLogDelivery",
          "logs:ListLogDeliveries",
          "logs:PutResourcePolicy",
          "logs:DescribeResourcePolicies",
          "logs:DescribeLogGroups"
        ]

        Resource = "*"
      }

    ]

  })

}

#########################################
# Step Function Policy Attachment
#########################################

resource "aws_iam_role_policy_attachment" "step_attach" {

  role = aws_iam_role.step_role.name

  policy_arn = aws_iam_policy.step_policy.arn
}