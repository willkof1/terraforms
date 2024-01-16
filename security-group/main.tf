resource "aws_security_group" "allow_test" {
  name        = "allow_test"
  description = "Allow test inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["179.209.181.182/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["179.209.181.182/32"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_security_group_rule" "allow_tls" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = local.regra
  security_group_id = local.regra
  lifecycle {
    create_before_destroy = true
  }
}