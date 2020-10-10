resource "aws_vpc" "NV_VPC" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "NV_VPC"
  }
}

resource "aws_internet_gateway" "NV_IGW" {
  vpc_id = aws_vpc.NV_VPC.id
  tags = {
    Name = "NV_IGW"
  }
  depends_on = [aws_vpc.NV_VPC]
}