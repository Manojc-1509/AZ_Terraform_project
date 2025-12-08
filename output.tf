# ------------------------------------------
# RESOURCE GROUP OUTPUTS
# ------------------------------------------

output "resource_group_name" {
  value = var.deploy_env ? try(module.resource_group[0].resource_group_name, null) : null
}

output "resource_group_id" {
  value = var.deploy_env ? try(module.resource_group[0].resource_group_id, null) : null
}


# ------------------------------------------
# NETWORK OUTPUTS
# ------------------------------------------

output "subnet_id" {
  value = var.deploy_env ? try(module.network[0].subnet_id, null) : null
}

output "vnet_id" {
  value = var.deploy_env ? try(module.network[0].vnet_id, null) : null
}


# ------------------------------------------
# APP SERVICE OUTPUTS
# ------------------------------------------


output "webapp_url" {
  value = var.deploy_env ? try(module.app_service[0].webapp_url, null) : null
}


# ------------------------------------------
# SHARED INFRA OUTPUTS
# ------------------------------------------

output "rg_shared_name" {
  value = var.shared_infra ? try(azurerm_resource_group.rg_shared[0].name, null) : null
}

output "acr_name" {
  value = var.shared_infra ? try(azurerm_container_registry.acr[0].name, null) : null
}

output "acr_login_server" {
  value = var.shared_infra ? try(azurerm_container_registry.acr[0].login_server, null) : null
}

output "acr_username" {
  value = var.shared_infra ? try(azurerm_container_registry.acr[0].admin_username, null) : null
}

output "acr_password" {
  value = var.shared_infra ? try(azurerm_container_registry.acr[0].admin_password, null) : null
  sensitive = true
}
