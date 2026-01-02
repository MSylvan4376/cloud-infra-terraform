variable "project_name" { type = string }
variable "environment"  { type = string }

variable "vpc_id" { type = string }

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "max_capacity" {
  type    = number
  default = 4
}

variable "min_capacity" {
  type    = number
  default = 1
}

# For now keep it open; later we can tighten to your public IP
variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

