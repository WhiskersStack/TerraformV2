resource "aws_security_group" "db_security_group" {
  name        = var.name        # "DB Security Group"
  description = var.description # "Permit access from Web Security Group"
  vpc_id      = var.vpc_id      # Lab VPC ID
  ingress {
    description     = "Allow MySQL from Web Security Group"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id] # Web SG ID
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "DB Security Group"
  }
}
