Cloud NAT – Private VM Outbound Internet Access
Objective

Enable outbound internet access for private GCP virtual machines without assigning public IP addresses, following production security best practices.

Problem Statement

Private VMs (no public IP) cannot:

Run apt update

Pull packages

Access external APIs

Send logs to external endpoints

At the same time, production security requires:

No inbound internet exposure

No public IPs on VMs

Solution: Cloud NAT

Cloud NAT allows egress-only internet access for private VMs by:

Translating private IPs to Google-managed public IPs

Blocking all inbound connections

Preserving private networking posture

Architecture Flow
Private VM
   |
   | (private IP)
   v
VPC Subnet
   |
Cloud Router
   |
Cloud NAT
   |
Internet (Outbound only)


Key point:
Inbound connections from the internet are impossible.

Terraform Implementation
Network Module Variables
variable "enable_cloud_nat" {
  description = "Enable Cloud NAT for private VM internet access"
  type        = bool
  default     = false
}

Cloud Router
resource "google_compute_router" "router" {
  count   = var.enable_cloud_nat ? 1 : 0
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.name
}

Cloud NAT
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

Production Configuration Example
module "network" {
  source          = "../../modules/network"
  vpc_name        = "devops-vpc-prod-v2"
  region          = "asia-south1"
  subnet_name     = "prod-subnet-asia"
  subnet_cidr     = "10.20.1.0/24"
  enable_cloud_nat = true
}

Security Characteristics
Aspect	Behavior
Inbound access	❌ Blocked
Public IP on VM	❌ None
Outbound internet	✅ Allowed
Logging	✅ Enabled
Blast radius	Minimal
Why Cloud NAT (instead of public IP)

No exposed attack surface

Centralized egress control

Google-managed IPs

Scales automatically

Auditable via logs

Key Takeaways

Cloud NAT is mandatory for secure production egress

Public IPs are never required for outbound access

This pattern is used in real enterprise GCP environments

✅ End of document
