variable "project_name" {
  description = "Project name prefix for all resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. production, staging, dev)."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (e.g. t3.micro, t3.small)."
  type        = string
}

variable "key_name" {
  description = "Name of an existing EC2 Key Pair. Leave empty to disable SSH key access."
  type        = string
  default     = ""
}

variable "ec2_security_group_id" {
  description = "Security Group ID to attach to EC2 instances launched by this template."
  type        = string
}

