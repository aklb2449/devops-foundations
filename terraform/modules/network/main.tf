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
resource "google_compute_router" "router" {
  count   = var.enable_cloud_nat ? 1 : 0
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat" {
  count                               = var.enable_cloud_nat ? 1 : 0
  name                                = "${var.vpc_name}-nat"
  router                             = google_compute_router.router[0].name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
resource "google_compute_subnetwork" "bastion_subnet" {
  count         = var.enable_bastion ? 1 : 0
  name          = var.bastion_subnet_name
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.bastion_subnet_cidr

  private_ip_google_access = true
}
resource "google_compute_firewall" "allow_bastion_ssh" {
  count   = var.enable_bastion ? 1 : 0
  name    = "${var.vpc_name}-allow-bastion-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.bastion_subnet_cidr]
  description   = "Allow SSH from Bastion subnet to private VMs"
}
# IAP → Bastion VM
resource "google_compute_firewall" "allow_iap_to_bastion" {
  count   = var.enable_bastion ? 1 : 0
  name    = "${var.vpc_name}-allow-iap-to-bastion"
  network = google_compute_network.vpc.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["bastion"]

  description = "Allow SSH to Bastion via IAP"
}
