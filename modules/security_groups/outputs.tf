output "alb_security_group_id" {
  description = "Security Group ID for the Application Load Balancer."
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "Security Group ID for the EC2 application instances."
  value       = aws_security_group.ec2.id
}

output "bastion_security_group_id" {
  description = "Security Group ID for the Bastion host."
  value       = aws_security_group.bastion.id
}
