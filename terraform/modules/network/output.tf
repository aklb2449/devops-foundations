output "network_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc.name
}
output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}
output "bastion_subnet_name" {
  value       = var.enable_bastion ? google_compute_subnetwork.bastion_subnet[0].name : null
  description = "Bastion subnet name"
}
