resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = google_compute_network.vpc.name

    access_config {
      # Public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  tags = ["ssh"]
}
