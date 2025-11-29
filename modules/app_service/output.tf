output "webapp_name" {
  value = azurerm_linux_web_app.webapp.name
}

output "default_hostname" {
  value = azurerm_linux_web_app.webapp.default_hostname
}

output "webapp_url" {
  description = "URL of the deployed Web App"
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}
