module "db_security_group" {
  source    = "./modules/security_group"
  vpc_id    = var.lab_vpc_id
  web_sg_id = var.web_sg_id
}
module "db_subnet_group" {
  source             = "./modules/db_subnet_group"
  private_subnet_ids = var.private_subnet_ids
}
module "rds" {
  source = "./modules/rds"

  db_subnet_group_name    = module.db_subnet_group.subnet_group_name
  db_username             = var.db_username
  db_password             = var.db_password
  vpc_security_group_ids  = [module.db_security_group.db_security_group_id]
}
output "notice" {
  value = "Endpoint: ${module.rds.rds_endpoint}"
}