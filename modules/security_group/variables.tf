variable "name" {
  description = "Name of the security group"
  type        = string
  default     = "DB Security Group"
}
variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Permit access from Web Security Group"
}
variable "vpc_id" {
  description = "ID of the Lab VPC"
  type        = string
}
variable "web_sg_id" {
  description = "ID of the Web Security Group"
  type        = string
}
