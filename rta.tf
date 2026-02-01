resource "aws_route_table_association" "public-RTA" {
  count          = length(var.public_cidr)
  subnet_id      = element(aws_subnet.public-subnet[*].id, count.index)
  route_table_id = aws_route_table.Public-RT-Terra.id
}

resource "aws_route_table_association" "private-RTA" {
  count          = length(var.private_cidr)
  subnet_id      = element(aws_subnet.private-subnet[*].id, count.index)
  route_table_id = aws_route_table.private-RT-Terra.id
}
