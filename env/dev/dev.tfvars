# Resource group part
shared_infra = false
resource_group_name = "dev-rg"
location = "central india"
deploy_env = true
vnet_address_space = ["10.0.0.0/16"]
subnet_address = ["10.0.1.0/24"]
env = "dev"
