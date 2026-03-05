module "rgroup" {
  source      = "./modules/rgroup-n01742406"
  location    = var.location
  common_tags = var.common_tags
}

module "network" {
  source              = "./modules/network-n01742406"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  common_tags         = var.common_tags
}

module "common" {
  source              = "./modules/common-n01742406"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  common_tags         = var.common_tags
}