# Resource group part
deploy_env = true
resource_group_name = "prod-rg"
location = "central india"

# Network part 

vnet_name = "prod-vnet"
vnet_address_space = ["10.20.0.0/16"]

# Subnet part
subnet_name = "prod-subnet"
subnet_address = ["10.20.1.0/24"]

# Storage part

storage_accout_name = "prodst1509"
fileshare_name = "prodfileshare"

# App service

webapp_name = "prod-container-webapp1509"
service_plan_name = "prod-appservice1509"

