resource "aws_instance" "ec2" {
  count         = 2
  ami           = "ami-0742b4e673072066f"
  instance_type = "t3.micro"
  #subnet_id              = "${element(var.subnets, count.index)}"
  subnet_id              = var.subnets[count.index]
  vpc_security_group_ids = [var.sg_will]
  key_name               = var.aws_public_keypair_name
  user_data              = file("install.sh")
  monitoring             = true
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
  }
  tags = {
    Name = "Nginx-${count.index + 1}"
    Env  = "Dev"
  }
}

resource "aws_eip" "ec2" {
  count    = 2
  instance = aws_instance.ec2[count.index].id
  vpc      = true
  tags = {
    Name = "Nginx"
    Env  = "Dev"
  }
}