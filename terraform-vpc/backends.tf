terraform {
  backend "s3" {
    bucket = "will-terraform-state-prod"
    key    = "state/terraform-sg.tfstate"
    region = "us-east-1"
  }
}