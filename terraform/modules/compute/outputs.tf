output "public_ip" {
  description = "Public IP of the VM (null if not assigned)"
  value = length(google_compute_instance.vm.network_interface[0].access_config) > 0 ? google_compute_instance.vm.network_interface[0].access_config[0].nat_ip : null
}


output "private_ip" {
  description = "Private IP of the VM"
  value       = google_compute_instance.vm.network_interface[0].network_ip
}
