terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "storageterraformjj"
    container_name       = "finance-infra"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "finance_rg" {
  name     = "finance-rg"
  location = var.location
}
