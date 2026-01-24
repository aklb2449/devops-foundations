resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow_ssh" {
  count   = var.enable_public_ssh ? 1 : 0
  name    = "${var.vpc_name}-allow-ssh-public"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

