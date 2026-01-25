module "network" {
  source       = "../../modules/network"
  vpc_name     = "devops-vpc-prod-v2"
  subnet_name  = "prod-subnet-asia"
  region       = "asia-south1"
  subnet_cidr  = "10.20.1.0/24"
  enable_cloud_nat = true
}
module "compute_green" {
  source            = "../../modules/compute"
  vm_name           = "devops-vm-prod-green"
  machine_type      = "e2-micro"
  zone              = "asia-south1-a"
  network_name      = module.network.network_name
  subnet_name       = module.network.subnet_name
  enable_public_ip  = false
}
