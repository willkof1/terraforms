variable "region" {
  default = "us-east-1"
}

variable "bucketName" {
  default = "test.wrnd.com.br"
}

variable "domain_name" {
  type        = string
  default     = "test.wrnd.com.br"
  description = "The domain name for the website."
}
