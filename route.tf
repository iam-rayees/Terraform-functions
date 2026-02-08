resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.Vpc_Terra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_Tera.id
  }

  tags = {
    Name       = "${var.vpc_name}_Public_RT"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.Vpc_Terra.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name       = "${var.vpc_name}_private_RT"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }
}

resource "aws_route_table_association" "public_RTA" {
  count          = var.environment == "production" ? 3 : 2
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "private_RTA" {
  count          = var.environment == "production" ? 3 : 2
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_RT.id
}
