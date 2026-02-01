resource "aws_instance" "public-instance" {
  ami = lookup(var.amis, var.aws_region)
  #   count                       = length(var.public_cidr)
  # count                  = var.env == "Prod" ? 3 : 1
  count                       = var.env == "Prod" ? length(var.public_cidr) : 1
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnet[*].id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.vpc_name}-Public-Server-${count.index + 1}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env
  }
}
