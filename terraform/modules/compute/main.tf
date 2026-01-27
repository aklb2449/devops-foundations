resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = var.network_name
    subnetwork = var.subnet_name
   dynamic "access_config" {
    for_each = var.enable_public_ip ? [1] : []
    content {}
  }
  }
  tags = var.is_bastion ? ["bastion"] : []
  metadata = {
    enable-oslogin = "TRUE"
  }
}
