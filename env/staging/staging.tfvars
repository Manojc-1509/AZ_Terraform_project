# Resource group part

resource_group_name = "staging-rg"
location = "central india"

# Network part 

vnet_name = "staging-vnet"
vnet_address_space = ["10.0.0.0/16"]

# Subnet part
subnet_name = "staging-subnet"
subnet_address = ["10.0.1.0/24"]

# Storage part

storage_accout_name = "prodst1509"
fileshare_name = "stagingfileshare"

# App service

webapp_name = "staging-container-webapp1509"
service_plan_name = "staging-appservice1509"

