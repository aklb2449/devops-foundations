module "network" {
  source   = "../../modules/network"
  vpc_name = "devops-vpc-prod"
}

module "compute" {
  source        = "../../modules/compute"
  vm_name       = "devops-vm-prod"
  machine_type  = "e2-micro"
  zone          = "asia-south1-a"
  network_name  = module.network.network_name
  enable_public_ip = false
}
