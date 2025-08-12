aws_region                = "us-east-1"
vpc_cidr                  = "10.0.0.0/16"
public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs      = ["10.0.101.0/24", "10.0.102.0/24"]
environment               = "dev"
tags = {
  Project = "MyApp"
  Owner   = "DevTeam"
}

create_internet_gateway   = false
create_nat_gateway        = false
create_public_route_table = false
create_private_route_table= false
create_subnets            = true
