resource "aws_instance" "NV_FrontEnd" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.NV_Allow_SSH.id]
  subnet_id = aws_subnet.NV_PublicSubnet_A.id
  key_name = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname nv-frontend
              EOF
  tags = {
    Name = "NV_FrontEnd"
  }
  depends_on = [aws_vpc.NV_VPC, aws_subnet.NV_PublicSubnet_A, aws_security_group.NV_Allow_SSH]
}

resource "aws_instance" "NV_API" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.NV_Allow_SSH.id]
  subnet_id = aws_subnet.NV_PrivateSubnet_A.id
  key_name = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname nv-api
              EOF
  tags = {
    Name = "NV_API"
  }
  depends_on = [aws_vpc.NV_VPC, aws_subnet.NV_PrivateSubnet_A, aws_security_group.NV_Allow_SSH]
}

resource "aws_instance" "NV_DB" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.NV_Allow_SSH.id]
  subnet_id = aws_subnet.NV_PrivateSubnet_A.id
  key_name = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname nv-db
              EOF
  tags = {
    Name = "NV_DB"
  }
  depends_on = [aws_vpc.NV_VPC, aws_subnet.NV_PrivateSubnet_A, aws_security_group.NV_Allow_SSH]
}