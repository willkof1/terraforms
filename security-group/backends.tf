terraform {
  backend "s3" {
    bucket = "will-terraform-state-prod"
    key    = "state/terraform-vpc-new.tfstate"
    region = "us-east-1"
  }
}