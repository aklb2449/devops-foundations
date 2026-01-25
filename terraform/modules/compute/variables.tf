variable "vm_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "enable_public_ip" {
  description = "Whether to assign a public IP to the VM"
  type        = bool
  default     = false
}
variable "subnet_name" {
  description = "Subnet where the VM will be deployed"
  type        = string
}

