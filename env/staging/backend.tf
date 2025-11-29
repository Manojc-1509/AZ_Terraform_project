terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-statefiles"            
    storage_account_name = "tfstatefiles1509"     
    container_name       = "shared-tf-files"               
    key                  = "staging/terraform.tfstate"
  }
}
