variable "aws_region" {
  default = "us-east-1"
}

variable "db_cluster_identifier" {
  default = "mysql-cluster"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID for the RDS cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for Multi-AZ deployment"
  type        = list(string)
}

variable "instance_class" {
  description = "Database instance type"
  default     = "db.r6g.large"
}

variable "allowed_cidr" {
  description = "CIDR block allowed for MySQL access"
  default     = "0.0.0.0/0" # Change for better security
}
