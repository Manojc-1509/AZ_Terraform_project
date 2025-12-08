# Resource group part
shared_infra = false
resource_group_name = "dev-rg"
location = "central india"
deploy_env = true
# Network part 

vnet_name = "dev-vnet"
vnet_address_space = ["10.0.0.0/16"]

# Subnet part
subnet_name = "dev-subnet"
subnet_address = ["10.0.1.0/24"]

# Storage part

storage_accout_name = "devst1509"
fileshare_name = "devfileshare"

# App service

webapp_name = "dev-container-webapp1509"
service_plan_name = "dev-appservice1509"

