resource "aws_route53_record" "www" {
  zone_id = "Z0210308P7Q8A92NCMX7"
  name    = "www.wrnd.com.br"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.my-aws-alb.dns_name]
}