resource "aws_security_group" "NV_Public_Security_Group" {
  name = "NV_Public_Security_Group"
  description = "Allow HTTP and SSH Inbound Traffic / Allow all Outbound traffic"
  vpc_id = aws_vpc.NV_VPC.id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0"]
  }

  tags = {
    Name = "NV_Public_Security_Group"
  }

  depends_on = [aws_vpc.NV_VPC]
}

resource "aws_security_group" "NV_Private_Security_Group" {
  name = "NV_Private_Security_Group"
  description = "Allow Inbound from Public Security Group / Allow all Outbound Traffic"
  vpc_id = aws_vpc.NV_VPC.id

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_groups = [ aws_security_group.NV_Public_Security_Group.id]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0"]
  }

  tags = {
    Name = "NV_Private_Security_Group"
  }
  depends_on = [aws_vpc.NV_VPC, aws_security_group.NV_Public_Security_Group]
}

resource "aws_security_group" "NV_Web_LB_Security_Group" {
  name = "NV_Web_LB_Security_Group"
  description = "Allow Web traffic to LB"
  vpc_id = aws_vpc.NV_VPC.id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0"]
  }

  tags = {
    Name = "NV_Web_LB_Security_Group"
  }
  depends_on = [aws_vpc.NV_VPC]
}