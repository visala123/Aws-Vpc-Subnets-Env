resource "aws_route_table" "private" {
  count  = var.create_private_route_table ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.environment}-private-rt"
  })
}

resource "aws_route" "nat_gateway_access" {
  count                  = var.create_private_route_table && var.create_nat_gateway && var.create_subnets ? length(aws_nat_gateway.this) : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[count.index].id
}

resource "aws_route_table_association" "private_subnets" {
  count          = var.create_private_route_table && var.create_subnets ? length(aws_subnet.private) : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}
