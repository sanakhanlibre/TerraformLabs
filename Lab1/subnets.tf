resource "aws_subnet" "NV_PublicSubnet_A" {
  cidr_block = var.public_subnet_cidr
  vpc_id = aws_vpc.NV_VPC.id
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "NV_PublicSubnet_A"
  }
  depends_on = [aws_vpc.NV_VPC]
}

resource "aws_subnet" "NV_PrivateSubnet_A" {
  cidr_block = var.private_subnet_cidr
  vpc_id = aws_vpc.NV_VPC.id
  availability_zone = var.availability_zone

  tags = {
    Name = "NV_PrivateSubnet_A"
  }
  depends_on = [aws_vpc.NV_VPC]
}

resource "aws_eip" "NV_NATGW_EIP" {
  vpc = true
  tags = {
    Name = "NV_NATGW_EIP"
  }
}

resource "aws_nat_gateway" "NV_NATGW" {
  allocation_id = aws_eip.NV_NATGW_EIP.id
  subnet_id = aws_subnet.NV_PublicSubnet_A.id
  tags = {
    Name = "NV_NATGW"
  }
  depends_on = [aws_eip.NV_NATGW_EIP,aws_subnet.NV_PublicSubnet_A]
}