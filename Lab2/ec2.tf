resource "aws_instance" "NV_FrontEnd" {
  count = length(var.public_subnet_cidr)
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.NV_Public_Security_Group.id]
  subnet_id = aws_subnet.NV_PublicSubnets[count.index].id
  key_name = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              apt install apache2
              systemctl start apache2
              echo "Hey There! I am Public EC2: $(hostname -f)" > /var/www/html/index.html
              EOF
  tags = {
    Name = format("NV_FrontEnd_%d", count.index+1)
  }
  depends_on = [aws_vpc.NV_VPC, aws_subnet.NV_PublicSubnets, aws_security_group.NV_Public_Security_Group]
}

resource "aws_instance" "NV_API" {
  count = length(var.private_subnet_cidr)
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.NV_Private_Security_Group.id]
  subnet_id = aws_subnet.NV_PrivateSubnets[count.index].id
  key_name = var.key_name
  user_data = <<-EOF
              apt install apache2
              systemctl start apache2
              echo "Hey There! I am Private EC2: $(hostname -f)" > /var/www/html/index.html
              EOF
  tags = {
    Name = format("NV_API_%d", count.index+1)
  }
  depends_on = [aws_vpc.NV_VPC, aws_subnet.NV_PrivateSubnets, aws_security_group.NV_Private_Security_Group]
}
