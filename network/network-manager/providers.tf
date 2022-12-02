terraform {
  required_version = "~> 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {

    }
    azapi = {
      source  = "azure/azapi"
      version = ">=0.1.0"
    }
  }
}

provider "azapi" {
}

provider "azurerm" {
    features {}

    tenant_id       = ""
    subscription_id = ""
    client_id       = ""
    client_secret   = ""
}