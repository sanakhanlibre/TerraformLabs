output "elb_dns_name" {
  value = aws_alb.NV_Web_LB.dns_name
}