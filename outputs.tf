output "resource_group_name" {
  value = module.rgroup.resource_group_name
}

output "virtual_network_name" {
  value = module.network.virtual_network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}