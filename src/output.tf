output "acr_url" {
  value = azurerm_container_registry.finance_acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.finance_acr.admin_username
}

output "acr_password" {
  value = nonsensitive(azurerm_container_registry.finance_acr.admin_password)
}
