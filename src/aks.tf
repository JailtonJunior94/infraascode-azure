resource "azurerm_kubernetes_cluster" "finance_aks" {
  name                = "finance-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.finance_rg.name

  dns_prefix = "finance-aks"
  sku_tier   = "Free"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}
