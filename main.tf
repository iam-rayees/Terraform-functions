provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "rayeez-terra-bucket-01"
    key    = "functions.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "VPC-Terra" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.vpc_name}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env
  }
}

resource "aws_internet_gateway" "IGW-Terra" {
  vpc_id = aws_vpc.VPC-Terra.id
  tags = {
    Name        = "${var.vpc_name}-IGW"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = var.env
  }
}
