output "resource_group_name" {
  value = module.rgroup.resource_group_name
}

output "virtual_network_name" {
  value = module.network.virtual_network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common.log_analytics_workspace_name
}

# output "recovery_services_vault_name" {
#   value = module.common.recovery_services_vault_name
# }

output "storage_account_name" {
  value = module.common.storage_account_name
}

output "vm_hostnames" {
  value = module.vmlinux.vm_hostnames
}

output "vm_fqdns" {
  value = module.vmlinux.vm_fqdns
}

output "vm_private_ips" {
  value = module.vmlinux.vm_private_ips
}

output "vm_public_ips" {
  value = module.vmlinux.vm_public_ips
}