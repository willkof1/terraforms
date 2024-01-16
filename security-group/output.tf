output "security_group_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.allow_test.arn
}