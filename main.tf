provider "aws" {
  region = var.region
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_1
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_2
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = var.db_subnet_group_name
  description = "My DB Subnet Group"

  subnet_ids = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id,
  ]
}

resource "aws_rds_cluster" "main" {
  cluster_identifier   = var.cluster_identifier
  database_name        = var.database_name
  master_username      = random_password.password.result
  master_password      = random_password.password.result
  port                 = 5432
  engine               = "aurora-postgresql"
  engine_version       = "14"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  storage_encrypted    = true
}

resource "aws_rds_cluster_instance" "main" {
  count             = var.instance_count
  identifier        = "myinstance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.main.id
  instance_class    = "db.r4.large"
  engine            = "aurora-postgresql"
  engine_version    = "14"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible = true
}

locals {
  db_creds = {
    username = random_password.password.result
    password = random_password.password.result
  }
}

