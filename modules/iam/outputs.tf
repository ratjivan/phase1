output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "step_role_arn" {
  value = aws_iam_role.step_role.arn
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}

output "step_role_name" {
  value = aws_iam_role.step_role.name
}