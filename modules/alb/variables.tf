variable "project_name" {
  description = "Project name prefix for all resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. production, staging, dev)."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC (required for the target group)."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs where the ALB will be deployed (one per AZ)."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID to attach to the ALB."
  type        = string
}
