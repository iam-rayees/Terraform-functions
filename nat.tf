resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name       = "${var.vpc_name}_NGW"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW_Tera]
}
