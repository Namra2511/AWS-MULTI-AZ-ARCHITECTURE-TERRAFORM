variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "A short name used to prefix all resource names."
  type        = string
  default     = "myapp"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,32}$", var.project_name))
    error_message = "project_name must be 1-32 characters and contain only letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Deployment environment (e.g. production, staging, dev)."
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of Availability Zones to deploy into."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

  validation {
    condition     = length(var.availability_zones) >= 2 && length(distinct(var.availability_zones)) == length(var.availability_zones)
    error_message = "Provide at least two unique Availability Zones."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "Provide exactly one public subnet CIDR for each Availability Zone."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "Provide exactly one private subnet CIDR for each Availability Zone."
  }
}

variable "ami_id" {
  description = "Optional explicit EC2 AMI ID. Leave empty to resolve the latest Canonical Ubuntu 22.04 LTS image in the selected region."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Optional EC2 Key Pair name. SSM Session Manager is the recommended access path; no SSH ingress is opened by default."
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances in the ASG."
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances in the ASG."
  type        = number
  default     = 6
}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 instances in the ASG."
  type        = number
  default     = 3

  validation {
    condition     = var.asg_min_size <= var.asg_desired_capacity && var.asg_desired_capacity <= var.asg_max_size
    error_message = "asg_desired_capacity must be between asg_min_size and asg_max_size."
  }
}

variable "cpu_target_utilization" {
  description = "Target CPU utilization (%) for the ASG scaling policy."
  type        = number
  default     = 70

  validation {
    condition     = var.cpu_target_utilization > 0 && var.cpu_target_utilization <= 100
    error_message = "cpu_target_utilization must be greater than 0 and at most 100."
  }
}
