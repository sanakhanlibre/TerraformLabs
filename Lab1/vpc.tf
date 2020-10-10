resource "aws_vpc" "NV_VPC" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "NV_VPC"
  }
}

resource "aws_security_group" "NV_Allow_SSH" {
  name = "NV_Allow_SSH"
  description = "Allow SSH Inbound Traffic / Allow all Outbound traffic"
  vpc_id = aws_vpc.NV_VPC.id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0"]
  }

  tags = {
    Name = "NV_Allow_SSH"
  }

  depends_on = [aws_vpc.NV_VPC]
}

resource "aws_internet_gateway" "NV_IGW" {
  vpc_id = aws_vpc.NV_VPC.id
  tags = {
    Name = "NV_IGW"
  }
  depends_on = [aws_vpc.NV_VPC]
}