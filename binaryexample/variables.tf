variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "secret_name" {
  description = "Name of the AWS Secrets Manager secret"
  type        = string
  default     = "Masteraccoundb"
}

