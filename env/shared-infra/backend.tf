terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-statefiles"             # change this
    storage_account_name = "tfstatefiles1509"     # change this
    container_name       = "shared-tf-files"                # change this
    key                  = "shared/terraform.tfstate"
  }
}
