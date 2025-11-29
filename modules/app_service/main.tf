resource "azurerm_service_plan" "appservice_plan" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.appservice_plan.id

  site_config {
    application_stack {
      docker_image_name        = "myhtmlsite:v1"                           # only repo:tag
      docker_registry_url      = "https://${var.acr_login_server}"         # ACR URL
      docker_registry_username = var.acr_username                          # admin user
      docker_registry_password = var.acr_password                          # admin password
    }
  }

  app_settings = {
    WEBSITES_PORT = "80"
  }
}
