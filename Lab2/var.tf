variable "region" {
}

variable "vpc_cidr" {
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-099c1869f33464fde"
}

variable "public_subnet_cidr" {
  type = list
}

variable "public_subnet_names" {
  type = list
}

variable "private_subnet_cidr" {
  type = list
}

variable "private_subnet_names" {
  type = list
}

variable "availability_zone" {
  type = list
}

variable "key_name" {
  default = "sana_key"
}