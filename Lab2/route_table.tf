resource "aws_route_table" "NV_PublicRouteTable" {
  vpc_id = aws_vpc.NV_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.NV_IGW.id
  }
  tags = {
    Name = "PV_PublicRouteTable"
  }
  depends_on = [aws_vpc.NV_VPC, aws_internet_gateway.NV_IGW]
}

resource "aws_route_table_association" "NV_PublicRouteTableAssociation" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.NV_PublicSubnets.*.id, count.index)
  route_table_id = aws_route_table.NV_PublicRouteTable.id
  depends_on = [aws_subnet.NV_PublicSubnets, aws_route_table.NV_PublicRouteTable]
}

resource "aws_route_table" "NV_PrivateRouteTable" {
  vpc_id = aws_vpc.NV_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NV_NATGW.id
  }
  tags = {
    Name = "NV_PrivateRouteTable"
  }
  depends_on = [aws_vpc.NV_VPC, aws_nat_gateway.NV_NATGW]
}

resource "aws_route_table_association" "NV_PrivateRouteTableAssociation" {
  count = length(var.private_subnet_cidr)
  route_table_id = aws_route_table.NV_PrivateRouteTable.id
  subnet_id = element(aws_subnet.NV_PrivateSubnets.*.id, count.index)
  depends_on = [aws_subnet.NV_PrivateSubnets, aws_route_table.NV_PrivateRouteTable]
}