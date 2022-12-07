terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
    }
  }
}

provider "azurerm" {
    features {}

    tenant_id       = ""
    subscription_id = ""
    client_id       = ""
    client_secret   = ""
}