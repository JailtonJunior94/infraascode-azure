resource "azurerm_container_registry" "finance_acr" {
  name                = "financesregistry"
  resource_group_name = azurerm_resource_group.finance_rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}
