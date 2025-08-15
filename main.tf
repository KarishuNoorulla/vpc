provider "google" {
  project = var.project_id
  region  = var.region
}

module "app_vm" {
  source     = "./modules/vm"
  project_id = var.project_id
  zone       = var.zone
  vm_name    = var.vm_name
}

module "anthos_cluster" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
}