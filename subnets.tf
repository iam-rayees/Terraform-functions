resource "aws_subnet" "public-subnet" {
  count             = length(var.public_cidr)
  vpc_id            = aws_vpc.VPC-Terra.id
  cidr_block        = element(var.public_cidr, count.index)
  availability_zone = element(var.az_name, count.index)

  tags = {
    Name        = "${var.vpc_name}-public-subnet-${count.index}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env
  }
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.private_cidr)
  vpc_id            = aws_vpc.VPC-Terra.id
  cidr_block        = element(var.private_cidr, count.index)
  availability_zone = element(var.az_name, count.index)

  tags = {
    Name        = "${var.vpc_name}-private-subnet-${count.index}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env
  }
}
