shared_infra = true
deploy_env   = false

resource_group_name = "rg-shared-infra"       # Not used
location            = "central india"
vnet_address_space = ["10.30.0.0/16"]
subnet_address = ["10.30.1.0/24"]
env = "shared"