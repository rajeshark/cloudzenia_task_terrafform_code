variable "region" {
    description = "aws region"
    type=string
}
variable "vpc_cidr" {
    description = "vpc cidr block"
    type=string
  
}
variable "public_subnet_1_cidr" {
    description = "public subnet 1 cidr block"
    type=string
}

variable "public_subnet_2_cidr"{
    description = "public subnet 2 cidr block"
    type=string
}
  

variable "private_subnet_1_cidr" {
    description = "private subnet 1 cidr block"
    type=string
}
variable "private_subnet_2_cidr" {
    description = "private subnet 2 cidr block"
    type=string
  
}
variable "az1" {
    description = "avaibility zone 1"
    type=string
  
}
variable "az2" {
    description = "avaibility zone 2"
    type=string
  
}
variable "engine_version_mysql" {
    description = "mysql engine version"
    type=string
  
}
variable "db_instance_class" {
    description = "db instance class"
    type=string
  
}
variable "db_storage" {
    description = "storage for my sql database"
    type=number
  
}
variable "db_storage_type" {
    description = "db storage type like gp3,gp2,io1,io2"
    type=string
  
}
variable "db_name" {
    type=string
  
}
variable "db_username" {
    type=string
  
}
variable "db_password" {
    type = string
  
}
variable "ami_id" {
    description = "ec2 ami id like amazon,ubuntu,redhat"
    type = string
  
}
variable "ec2_instance_type" {
    type=string
  
}
variable "domain_name" {
    type=string
  
}