variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "region" {
  description = "Region where subnet will be created"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
}

variable "enable_public_ssh" {
  description = "Allow SSH from public internet (DEV only)"
  type        = bool
  default     = false
}
