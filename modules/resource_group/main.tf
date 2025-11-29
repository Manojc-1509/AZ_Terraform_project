resource "azurerm_resource_group" "gr" {
  name = var.resource_group_name
  location = var.location
}