output "vpc" {
  value = aws_vpc.NV_VPC
}

output "vpc_id" {
  value = aws_vpc.NV_VPC.id
}

output "vpc_cidr" {
  value = aws_vpc.NV_VPC.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.NV_PublicSubnet_A.id
}

output "private_subnet_id" {
  value = aws_subnet.NV_PrivateSubnet_A.id
}