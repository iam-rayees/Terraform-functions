resource "aws_route_table" "Public-RT-Terra" {
  vpc_id = aws_vpc.VPC-Terra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-Terra.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-RT"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env

  }
}

resource "aws_route_table" "private-RT-Terra" {
  vpc_id = aws_vpc.VPC-Terra.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Nat-GateWay.id
  }

  tags = {
    Name        = "${var.vpc_name}-private-RT"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env

  }
}
