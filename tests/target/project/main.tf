provider "aws" {
  region = var.aws_region
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "mysql-cluster-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql-cluster-sg"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "mysql-subnet-group"
  }
}

# RDS MySQL Cluster
resource "aws_rds_cluster" "mysql_cluster" {
  cluster_identifier      = var.db_cluster_identifier
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  master_username         = var.db_username
  master_password         = var.db_password
  backup_retention_period = 7
  preferred_backup_window = "02:00-03:00"
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  apply_immediately       = true

  # Enable IAM Authentication
  enable_http_endpoint = true

  tags = {
    Name = "MySQLCluster"
  }
}

# RDS Cluster Instances
resource "aws_rds_cluster_instance" "mysql_instances" {
  count              = 2 # Two instances for HA
  identifier         = "${var.db_cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.mysql_cluster.id
  instance_class     = var.instance_class
  engine             = "aurora-mysql"
  publicly_accessible = false

  tags = {
    Name = "MySQLClusterInstance-${count.index}"
  }
}
