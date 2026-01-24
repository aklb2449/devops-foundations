variable "vpc_name" {
  type = string
}
variable "enable_public_ssh" {
  description = "Allow SSH from public internet"
  type        = bool
  default     = false
}
