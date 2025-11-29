output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "resource_group_id" {
  value = module.resource_group.resource_group_id
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "webapp_url" {
  value = module.app_service.webapp_url
}
