resource "aws_eip" "Elastic-IP" {
  domain = "vpc"
}

resource "aws_nat_gateway" "Nat-GateWay" {
  allocation_id = aws_eip.Elastic-IP.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    Name        = "${var.vpc_name}-NATgateway"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env

  }
  depends_on = [aws_internet_gateway.IGW-Terra]
}
