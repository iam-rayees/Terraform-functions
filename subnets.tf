resource "aws_subnet" "public_subnets" {
  count             = var.environment == "production" ? 3 : 2
  vpc_id            = aws_vpc.Vpc_Terra.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.az_name, count.index)

  tags = {
    Name       = "${var.vpc_name}_public_subnet_${count.index + 1}"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }
}

resource "aws_subnet" "private_subnets" {
  count             = var.environment == "production" ? 3 : 2
  vpc_id            = aws_vpc.Vpc_Terra.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.az_name, count.index)

  tags = {
    Name       = "${var.vpc_name}_private_subnet_${count.index + 1}"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }

  depends_on = [aws_nat_gateway.nat_gw]
}
