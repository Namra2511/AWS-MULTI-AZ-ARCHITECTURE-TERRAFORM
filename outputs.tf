output "alb_dns_name" {
  description = "ALB DNS name."
  value       = module.alb.alb_dns_name
}

output "alb_url" {
  description = "Open this in your browser to verify the deployment."
  value       = "http://${module.alb.alb_dns_name}/"
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = module.vpc.private_subnet_ids
}

output "alb_security_group_id" {
  description = "Security Group ID attached to the ALB."
  value       = module.security_groups.alb_security_group_id
}

output "ec2_security_group_id" {
  description = "Security Group ID attached to EC2 instances."
  value       = module.security_groups.ec2_security_group_id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group."
  value       = module.autoscaling.asg_name
}

output "launch_template_id" {
  description = "ID of the EC2 Launch Template."
  value       = module.ec2.launch_template_id
}

output "test_lb_cmd_curl" {
  description = "Verify load balancing via curl (Git Bash / WSL / macOS)."
  value       = "for i in $(seq 1 15); do curl -s http://${module.alb.alb_dns_name}/api/status | python3 -c \"import sys,json; d=json.load(sys.stdin); print(d['private_ip'], d['instance_id'], d['az'])\"; done"
}

output "test_lb_cmd_powershell" {
  description = "Verify load balancing via PowerShell."
  value       = "1..15 | % { (Invoke-RestMethod http://${module.alb.alb_dns_name}/api/status) | Select-Object private_ip, instance_id, az }"
}
