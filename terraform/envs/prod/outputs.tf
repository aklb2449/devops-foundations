output "vm_private_ip" {
  description = "Private IP of PROD GREEN VM"
  value       = module.compute_green.private_ip
}

