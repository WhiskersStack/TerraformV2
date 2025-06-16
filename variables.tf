variable "lab_vpc_id" {
  description = "The ID of the Lab VPC"
  type        = string
}
variable "web_sg_id" {
  description = "The ID of the Web Security Group"
  type        = string
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS subnet group"
  type        = list(string)
}
variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}
variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}