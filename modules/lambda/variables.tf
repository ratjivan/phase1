variable "function_name" {
  type = string
}

variable "lambda_source" {
  type = string
}

variable "handler" {
  type    = string
  default = "index.lambda_handler"
}

variable "runtime" {
  type    = string
  default = "python3.13"
}

variable "role_arn" {
  type = string
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}