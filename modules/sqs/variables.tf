variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "max_receive_count" {
  description = "Number of retries before moving message to DLQ"
  type        = number
  default     = 3
}

variable "message_retention_seconds" {
  description = "Retention period for messages"
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout"
  type        = number
  default     = 30
}