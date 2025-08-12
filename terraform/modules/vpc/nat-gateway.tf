# resource "aws_eip" "nat" {
#   count = var.create_nat_gateway && var.create_subnets ? length(aws_subnet.public) : 0

#   tags = merge(var.tags, {
#     Name = "${var.environment}-nat-eip-${count.index + 1}"
#   })
# }

# resource "aws_nat_gateway" "this" {
#   count = var.create_nat_gateway && var.create_subnets ? length(aws_subnet.public) : 0

#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id
#   depends_on    = [aws_internet_gateway.this]

#   tags = merge(var.tags, {
#     Name = "${var.environment}-nat-gateway-${count.index + 1}"
#   })
# }

resource "aws_eip" "nat" {
  count = var.create_nat_gateway && var.create_subnets ? 1 : 0

  tags = merge(var.tags, {
    Name = "${var.environment}-nat-eip"
  })
}

resource "aws_nat_gateway" "this" {
  count         = var.create_nat_gateway && var.create_subnets ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.this]

  tags = merge(var.tags, {
    Name = "${var.environment}-nat-gateway"
  })
}
