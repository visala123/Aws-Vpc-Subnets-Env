variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "environment" {
  type        = string
  description = "Environment name, e.g. dev or prod"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

# Feature flags to control resource creation
variable "create_internet_gateway" {
  type    = bool
  default = true
}

variable "create_nat_gateway" {
  type    = bool
  default = true
}

variable "create_public_route_table" {
  type    = bool
  default = true
}

variable "create_private_route_table" {
  type    = bool
  default = true
}

variable "create_subnets" {
  type    = bool
  default = true
}
