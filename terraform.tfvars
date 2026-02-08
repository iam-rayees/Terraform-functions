aws_region          = "us-east-1"
vpc_cidr            = "172.16.0.0/16"
vpc_name            = "AWS_Terra_VPC"
public_subnet_cidr  = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
az_name             = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnet_cidr = ["172.16.10.0/24", "172.16.20.0/24", "172.16.30.0/24"]
environment         = "development"
service_ports       = ["80", "443", "22", "8080", "8443", "3306", "1900", "1443"]
amis = {
  us-east-1 = "ami-0b6c6ebed2801a5cb"
  us-east-2 = "ami-06e3c045d79fd65d9"
}
