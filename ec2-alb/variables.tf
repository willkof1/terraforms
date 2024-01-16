variable "aws_region" {}
variable "vpc_cidr" {}
variable "aws_public_keypair_name" {}
variable "public-subnet-us-east-1a" {}
variable "public-subnet-us-east-1b" {}
variable "sg_will" {}
variable "azs" {}
variable "instance_type" {
  type    = list(string)
  default = ["t3.micro", "c5.large"]
}
variable "vpc_id" {}
variable "subnets" {
  default = ["subnet-06060f7cd8b84c789", "subnet-03ab19be2d59fd559"]
}