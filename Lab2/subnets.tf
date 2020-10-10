resource "aws_subnet" "NV_PublicSubnets" {
  count = length(var.public_subnet_cidr)
  cidr_block = element(var.public_subnet_cidr,count.index )
  vpc_id = aws_vpc.NV_VPC.id
  availability_zone = element(var.availability_zone,count.index )
  map_public_ip_on_launch = true

  tags = {
    Name = element(var.public_subnet_names,count.index)
  }
  depends_on = [aws_vpc.NV_VPC]
}

resource "aws_subnet" "NV_PrivateSubnets" {
  count = length(var.private_subnet_cidr)
  cidr_block = element(var.private_subnet_cidr,count.index )
  vpc_id = aws_vpc.NV_VPC.id
  availability_zone = element(var.availability_zone,count.index )

  tags = {
    Name = element(var.private_subnet_names,count.index )
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
  subnet_id = aws_subnet.NV_PublicSubnets[0].id
  tags = {
    Name = "NV_NATGW"
  }
  depends_on = [aws_eip.NV_NATGW_EIP,aws_subnet.NV_PublicSubnets]
}