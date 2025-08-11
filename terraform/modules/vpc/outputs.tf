output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  value = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : ""
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.this[*].id
}

output "public_route_table_id" {
  value = length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : ""
}

output "private_route_table_id" {
  value = length(aws_route_table.private) > 0 ? aws_route_table.private[0].id : ""
}
