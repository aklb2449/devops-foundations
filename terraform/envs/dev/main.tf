module "network" {
  source   = "../../modules/network"
  vpc_name = "devops-vpc-dev"
}

module "compute" {
  source        = "../../modules/compute"
  vm_name       = "devops-vm-dev"
  machine_type  = "e2-micro"
  zone          = "asia-south1-a"
  network_name  = module.network.vpc_name
}
