aws_region    = "us-east-1"
vpc_cidr      = "172.18.0.0/16"
vpc_name      = "AWS-Terra-VPC"
public_cidr   = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cidr  = ["172.18.10.0/24", "172.18.20.0/24"]
az_name       = ["us-east-1a", "us-east-1b", "us-east-1c"]
env           = "Prod"
service_ports = ["80", "443", "8080", "8443", "22", "1443", "3306", "1900"]
amis = {
  us-east-1 = "ami-0b6c6ebed2801a5cb"
  us-east-2 = "ami-06e3c045d79fd65d9"
}
key_name = "Linux_secfile"
