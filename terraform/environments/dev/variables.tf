variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "create_internet_gateway" {
  type = bool
}

variable "create_nat_gateway" {
  type = bool
}

variable "create_public_route_table" {
  type = bool
}

variable "create_private_route_table" {
  type = bool
}

variable "create_subnets" {
  type = bool
}
