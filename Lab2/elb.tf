resource "aws_alb" "NV_Web_LB" {
  load_balancer_type = "application"
  name = "NV-Web-LB"
  internal = false
  security_groups = [aws_security_group.NV_Web_LB_Security_Group.id]
  subnets = aws_subnet.NV_PublicSubnets.*.id
  depends_on = [aws_subnet.NV_PublicSubnets, aws_security_group.NV_Web_LB_Security_Group]

  tags = {
    Name = "NV_Web_LB"
  }
}

resource "aws_alb_target_group" "NV_Web_TG" {
  name = "NV-Web-TG"
  vpc_id = aws_vpc.NV_VPC.id
  port = 80
  protocol = "HTTP"
  health_check {
        path = "/"
        port = "80"
        protocol = "HTTP"
        healthy_threshold = 5
        unhealthy_threshold = 2
        interval = 5
        timeout = 4
        matcher = "200"
  }
  tags = {
    Name = "NV_Web_TG"
  }
  depends_on = [aws_vpc.NV_VPC]
}

resource "aws_alb_target_group_attachment" "NV_Web_TGAttach" {
  target_group_arn = aws_alb_target_group.NV_Web_TG.arn
  count = length(var.public_subnet_cidr)
  port = 80
  target_id = element(aws_instance.NV_FrontEnd.*.id,count.index )
}

resource "aws_alb_listener" "NV_Web_LB_Listener" {
  load_balancer_arn = aws_alb.NV_Web_LB.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.NV_Web_TG.arn
  }

  depends_on = [aws_alb.NV_Web_LB,aws_alb_target_group.NV_Web_TG]
}