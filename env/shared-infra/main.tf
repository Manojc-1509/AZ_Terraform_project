resource "azurerm_resource_group" "rg_shared" {
  name = "rg-shared-infra"
  location = "central india"
}

# Create a containter registry

resource "azurerm_container_registry" "acr" {
  name                = "sharedcontainer1509"
  resource_group_name = azurerm_resource_group.rg_shared.name
  location            = "central india"
  sku                 = "Basic"
  admin_enabled       = true        # <<< MAKE THIS TRUE
}