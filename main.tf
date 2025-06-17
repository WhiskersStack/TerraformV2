############################################
# Look-ups for resources you created manually
############################################

# 1) Lab VPC
data "aws_vpc" "lab" {
  filter {
    name   = "tag:Name"
    values = ["Lab VPC"]
  }
}

# 2) Web Security Group
data "aws_security_group" "web" {
  filter {
    name   = "tag:Name"          # native attribute
    values = ["Web Security Group"]  #  ← must match exactly
  }
}

# 3) Private Subnet 1
data "aws_subnet" "private1" {
  filter {
    name   = "tag:Name"
    values = ["Private Subnet 1"]
  }
}

# 4) Private Subnet 2
data "aws_subnet" "private2" {
  filter {
    name   = "tag:Name"
    values = ["Private Subnet 2"]
  }
}

# 5) Existing EC2 Instance
data "aws_instances" "by_name" {
  filter {
    name   = "tag:Name"
    values = ["Web Server 1"]
  }
}

# Read the first matching ID
data "aws_instance" "existing" {
  instance_id = one(data.aws_instances.by_name.ids)
}


############################################
# Existing modules now fed by the look-ups
############################################

module "db_security_group" {
  source    = "./modules/security_group"
  vpc_id    = data.aws_vpc.lab.id
  web_sg_id = data.aws_security_group.web.id
}

module "db_subnet_group" {
  source = "./modules/db_subnet_group"
  private_subnet_ids = [
    data.aws_subnet.private1.id,
    data.aws_subnet.private2.id
  ]
}

module "rds" {
  source = "./modules/rds"

  db_subnet_group_name   = module.db_subnet_group.subnet_group_name
  db_username            = var.db_username
  db_password            = var.db_password
  vpc_security_group_ids = [module.db_security_group.db_security_group_id]
}

output "Endpoint" {
  value = module.rds.rds_endpoint
}
output "DB_name" {
  value = "jen_db"
}
output "User_name" {
  value = "Jen"
}
output "Password" {
  value = "12341234"
}
output "Public_ip" {
  description = "Public IP of the manually-created EC2 instance"
  value       = data.aws_instance.existing.public_ip
}
