#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "rayeez-terra-bucket-01"
    key    = "development.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}

resource "aws_vpc" "Vpc_Terra" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name       = "${var.vpc_name}"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter
  }
}

resource "aws_internet_gateway" "IGW_Tera" {
  vpc_id = aws_vpc.Vpc_Terra.id
  tags = {
    Name       = "${var.vpc_name}_IGW"
    Owner      = local.Owner
    TeamDL     = local.TeamDL
    costcenter = local.costcenter

  }
}

