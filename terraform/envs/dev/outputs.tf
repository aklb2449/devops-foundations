output "vm_public_ip" {
  description = "Public IP of dev VM"
  value       = module.compute.public_ip
}
