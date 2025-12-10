# -------------------------------------
# SHARED INFRA (ACR) – Created ONLY when shared_infra = true
# -------------------------------------

resource "azurerm_resource_group" "rg_shared" {
  count    = var.shared_infra ? 1 : 0
  name     = "rg-shared-infra"
  location = "central india"
}

resource "azurerm_container_registry" "acr" {
  count               = var.shared_infra ? 1 : 0
  name                = "sharedcontainer1509"
  resource_group_name = azurerm_resource_group.rg_shared[0].name
  location            = "central india"
  sku                 = "Basic"
  admin_enabled       = true
}


# -------------------------------------
# REMOTE STATE (only used for Dev/Prod)
# -------------------------------------

module "remote_state" {
  count = var.shared_infra ? 0 : 1

  source            = "./modules/remote_state"
  tfstate_rg        = "Terraform-statefiles"
  tfstate_sa        = "tfstatefiles1509"
  tfstate_container = "testing"
  tfstate_key       = "shared/terraform.tfstate"
}


# -------------------------------------
# ENVIRONMENT RESOURCE GROUP
# -------------------------------------

module "resource_group" {
  count               = var.deploy_env ? 1 : 0
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}


# -------------------------------------
# NETWORK
# -------------------------------------

module "network" {
  count               = var.deploy_env ? 1 : 0
  source              = "./modules/network"
  resource_group_name = module.resource_group[0].resource_group_name
  vnet_name           = "${var.env}-Vnet"
  location            = var.location
  vnet_address_space  = var.vnet_address_space
  subnet_address      = var.subnet_address
  subnet_name         = "${var.env}-subnet"
}


# -------------------------------------
# STORAGE
# -------------------------------------

module "storage_accout" {
  count               = var.deploy_env ? 1 : 0
  source              = "./modules/storage"
  resource_group_name = module.resource_group[0].resource_group_name
  location            = var.location
  storage_accout_name = "${var.env}storage1509"
  fileshare_name      = "${var.env}-fileshare"
}


# -------------------------------------
# APP SERVICE — Uses ACR (either created or remote)
# -------------------------------------

module "app_service" {
  count               = var.deploy_env ? 1 : 0
  source              = "./modules/app_service"
  resource_group_name = module.resource_group[0].resource_group_name
  location            = var.location
  service_plan_name   = "${var.env}-appservice1509"
  webapp_name         = "${var.env}-container-webapp1509"
  subnet_id           = module.network[0].subnet_id

  # Use ACR only if shared_infra = true, else use remote state
  acr_login_server = var.shared_infra ? azurerm_container_registry.acr[0].login_server : try(module.remote_state[0].acr_login_server, null)

  acr_username = var.shared_infra ? azurerm_container_registry.acr[0].admin_username : try(module.remote_state[0].acr_username, null)

  acr_password = var.shared_infra ? azurerm_container_registry.acr[0].admin_password : try(module.remote_state[0].acr_password, null)
}
