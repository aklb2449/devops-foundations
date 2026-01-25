module "network" {
  source            = "../../modules/network"
  vpc_name          = "devops-vpc-dev"
  region            = "asia-south1"
  subnet_name       = "dev-subnet-asia"
  subnet_cidr       = "10.10.1.0/24"
  enable_public_ssh = true
}

module "compute" {
  source            = "../../modules/compute"
  vm_name           = "devops-vm-dev"
  machine_type      = "e2-micro"
  zone              = "asia-south1-a"
  network_name      = module.network.network_name
  subnet_name       = module.network.subnet_name
  enable_public_ip  = true
}
