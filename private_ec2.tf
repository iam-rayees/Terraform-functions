resource "aws_instance" "private-instance" {
  ami = lookup(var.amis, var.aws_region)
  # count                  = length(var.private_cidr)
  # count                  = var.env == "Prod" ? 3 : 1
  count                  = var.env == "Prod" ? length(var.private_cidr) : 1
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = element(aws_subnet.private-subnet[*].id, count.index)
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  tags = {
    Name        = "${var.vpc_name}-private-Server-${count.index + 1}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env
  }
}
