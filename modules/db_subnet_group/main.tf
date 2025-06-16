resource "aws_db_subnet_group" "RDS_subnet_group" {
  name        = "rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Environment = "dev"
  }
}
