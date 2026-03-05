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
  depends_on          = [module.rgroup]
}

module "common" {
  source              = "./modules/common-n01742406"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  common_tags         = var.common_tags
  depends_on          = [module.rgroup]
}

module "vmlinux" {
  source              = "./modules/vmlinux-n01742406"
  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  common_tags         = var.common_tags
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.sa_primary_blob_endpoint
  depends_on          = [module.network, module.common]
}