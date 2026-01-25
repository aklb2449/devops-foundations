resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Public SSH (DEV only)
resource "google_compute_firewall" "allow_ssh" {
  count   = var.enable_public_ssh ? 1 : 0
  name    = "${var.vpc_name}-allow-ssh-public"
  network = google_compute_network.vpc.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# IAP SSH (DEV + PROD)
resource "google_compute_firewall" "allow_iap_ssh" {
  name        = "${var.vpc_name}-allow-iap-ssh"
  network    = google_compute_network.vpc.name
  direction  = "INGRESS"
  description = "Allow SSH access via Google IAP"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}
