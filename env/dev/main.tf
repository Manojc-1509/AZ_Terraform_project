data "terraform_remote_state" "shared" {
  backend = "azurerm"
  config = {
    resource_group_name  = "Terraform-statefiles"
    storage_account_name = "tfstatefiles1509"
    container_name       = "shared-tf-files"
    key                  = "shared/terraform.tfstate"
  }
}

module "resource_group" {
  source              = "../../modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = var.vnet_name
  location            = var.location
  vnet_address_space  = var.vnet_address_space
  subnet_address      = var.subnet_address
  subnet_name         = var.subnet_name
}

module "storage_accout" {
  source              = "../../modules/storage"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  storage_accout_name = var.storage_accout_name
  fileshare_name      = var.fileshare_name
}

module "app_service" {
  source              = "../../modules/app_service"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  service_plan_name   = var.service_plan_name
  acr_login_server    = data.terraform_remote_state.shared.outputs.acr_login_server
  acr_username        = data.terraform_remote_state.shared.outputs.acr_username
  acr_password        = data.terraform_remote_state.shared.outputs.acr_password
  webapp_name = var.webapp_name
}
