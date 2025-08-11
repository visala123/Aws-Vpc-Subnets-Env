provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  environment          = var.environment
  tags                 = var.tags

  create_internet_gateway    = var.create_internet_gateway
  create_nat_gateway         = var.create_nat_gateway
  create_public_route_table  = var.create_public_route_table
  create_private_route_table = var.create_private_route_table
  create_subnets             = var.create_subnets
}
