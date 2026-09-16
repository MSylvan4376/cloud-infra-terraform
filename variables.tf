variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-2"

  validation {
    condition     = can(regex("^[a-z]{2}(-[a-z]+)+-[0-9]+$", var.aws_region))
    error_message = "aws_region must be a valid AWS Region name, such as us-west-2."
  }
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "netboxlabs-demo"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,31}$", var.project_name))
    error_message = "project_name must be 3-32 characters, begin with a lowercase letter, and contain only lowercase letters, numbers, or hyphens."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, staging, or prod."
  }
}
