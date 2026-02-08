resource "aws_instance" "public_instances" {
  count                       = var.environment == "production" ? 3 : 2
  ami                         = lookup(var.amis, var.aws_region)
  availability_zone           = element(var.az_name, count.index)
  instance_type               = "t2.micro"
  key_name                    = "Linux_secfile"
  subnet_id                   = element(aws_subnet.public_subnets[*].id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "${var.vpc_name}_Public_Server_${count.index + 1}"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }

}


resource "aws_instance" "private_instances" {
  count                  = var.environment == "production" ? 3 : 2
  ami                    = lookup(var.amis, var.aws_region)
  availability_zone      = element(var.az_name, count.index)
  instance_type          = "t2.micro"
  key_name               = "Linux_secfile"
  subnet_id              = element(aws_subnet.private_subnets[*].id, count.index)
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  tags = {
    Name       = "${var.vpc_name}_private_Server_${count.index + 1}"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }
  user_data = <<-EOF
    #!/bin/bash
    set -e
    
    sudo apt-get update -y
    sudo apt-get install -y nginx
    rm -f /var/www/html/index.nginx-debian.html
    
    echo "<h1>It works from user_data on Private_servers!</h1>" > /var/www/html/index.html
    
    sudo systemctl restart nginx
    sudo systemctl enable nginx
EOF

}
