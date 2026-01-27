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
# 🔥 NEW (THIS IS ALL YOU ADD)
variable "enable_cloud_nat" {
  description = "Enable Cloud NAT for private subnets (PROD)"
  type        = bool
  default     = false
}
variable "enable_bastion" {
  description = "Enable bastion subnet and bastion SSH firewall rule"
  type        = bool
  default     = false
}

variable "bastion_subnet_name" {
  description = "Name of bastion subnet"
  type        = string
  default     = null
}

variable "bastion_subnet_cidr" {
  description = "CIDR for bastion subnet"
  type        = string
  default     = null
}