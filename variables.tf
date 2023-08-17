variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_1" {
  description = "CIDR block of Subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_2" {
  description = "CIDR block of Subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "db_subnet_group_name" {
  description = "Name for the RDS DB subnet group"
  type        = string
  default     = "my-db-subnet-group"
}

variable "cluster_identifier" {
  description = "Identifier for the RDS cluster"
  type        = string
  default     = "democluster"
}

variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "maindb"
}

variable "instance_count" {
  description = "Number of RDS instances"
  type        = number
  default     = 2
}

