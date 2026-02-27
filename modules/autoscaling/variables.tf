variable "project_name" {
  description = "Project name prefix for all resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. production, staging, dev)."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to launch EC2 instances in (one per AZ)."
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB Target Group to register ASG instances with."
  type        = string
}

variable "launch_template_id" {
  description = "ID of the EC2 Launch Template to use for instances."
  type        = string
}

variable "launch_template_version" {
  description = "Version of the Launch Template to use (use '$Latest' or a specific number)."
  type        = string
  default     = "$Latest"
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances."
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances."
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
}

variable "cpu_target_utilization" {
  description = "Target average CPU utilization (%) for the scaling policy."
  type        = number
  default     = 70
}
