variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "asia-south1-a"
}

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "devops-terraform-vm"
}

variable "machine_type" {
  description = "VM machine type"
  type        = string
  default     = "e2-micro"
}
