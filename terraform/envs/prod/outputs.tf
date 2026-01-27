output "vm_private_ip" {
  description = "Private IP of PROD GREEN VM"
  value       = module.compute_green.private_ip
}
output "bastion_public_ip" {
  value = module.bastion.public_ip
}

