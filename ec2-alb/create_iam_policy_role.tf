resource "aws_iam_policy" "policy" {
  name        = "policy-ec2-s3"
  description = "Policy para ec2 ter permissao no s3"
  policy      = file("policys3bucket.json")
}

resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = file("assumerolepolicy.json")
}