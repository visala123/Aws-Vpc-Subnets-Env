resource "aws_route_table" "public" {
  count  = var.create_public_route_table ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.environment}-public-rt"
  })
}

resource "aws_route" "internet_access" {
  count                 = var.create_public_route_table && var.create_internet_gateway ? 1 : 0
  route_table_id        = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id            = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public_subnets" {
  count          = var.create_public_route_table && var.create_subnets ? length(aws_subnet.public) : 0
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}
