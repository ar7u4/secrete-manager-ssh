provider "aws" {
  region = var.region
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "secretmasterDB" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = jsonencode({
    "username": "adminaccount",
    "password": random_password.password.result
  })
}

data "aws_secretsmanager_secret" "imported_secretmasterDB" {
  arn = aws_secretsmanager_secret.secretmasterDB.arn
}

data "aws_secretsmanager_secret_version" "imported_creds" {
  secret_id = data.aws_secretsmanager_secret.imported_secretmasterDB.arn
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.imported_creds.secret_string)
}

