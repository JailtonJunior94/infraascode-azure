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

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.finance_aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.finance_aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.finance_aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.finance_aks.kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_secret" "acr_secret" {
  metadata {
    name = "regcred"
  }

  data = {
    ".dockerconfigjson" = <<DOCKER
      {
        "auths": {
          "${azurerm_container_registry.finance_acr.login_server}": {
            "auth": "${base64encode("${azurerm_container_registry.finance_acr.admin_username}:${azurerm_container_registry.finance_acr.admin_password}")}"
          }
        }
      }
      DOCKER
  }

  type = "kubernetes.io/dockerconfigjson"
  depends_on = [
    azurerm_container_registry.finance_acr,
    azurerm_kubernetes_cluster.finance_aks
  ]
}
