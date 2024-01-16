terraform {
  backend "s3" {
    bucket = "will-terraform-state-prod"
    key    = "state/ec2-alb-new.tfstate"
    region = "us-east-1"
  }
}
