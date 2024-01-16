terraform {
  backend "s3" {
    bucket = "will-terraform-state-prod"
    key    = "state/s3-new.tfstate"
    region = "us-east-1"
  }
}
