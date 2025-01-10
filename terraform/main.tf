module "network" {
  source      = "./modules/network"
  environment = var.environment
  region      = var.region
}

module "compute" {
  source                 = "./modules/compute"
  environment            = var.environment
  vpc_self_link          = module.network.vpc_self_link
  subnet_self_link       = module.network.subnet_self_link
  machine_type           = "e2-medium"
  source_image           = "ubuntu-os-cloud/ubuntu-2004-lts"
  region                 = var.region
  zones                  = var.zones
  min_replicas           = 1
  max_replicas           = 3
  cpu_utilization_target = 0.6
}

module "database" {
  source           = "./modules/database"
  environment      = var.environment
  database_version = "MYSQL_8_0"
  region           = var.region
  db_tier          = "db-f1-micro"
  db_name          = "app-db"
  db_user          = var.db_user
  db_password      = var.db_password
  private_network  = module.network.vpc_self_link
}

module "storage" {
  source              = "./modules/storage"
  environment         = var.environment
  region              = var.region
  logging_bucket_name = var.logging_bucket_name
}
