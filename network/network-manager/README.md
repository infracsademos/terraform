# Azure Network Manager

This repo contains a demo case to get familiar with Azure Network Manager. Please refer to Azure Documentation space to gather more detailed inforamtion about the product which is currently in `Public Preview`. Docs are linked at the bottom of the page.

## Getting started

- Init terraform and provide details on `provider.tf` information.
  
  ```shell
  terraform init 
  ```

  ```terraform providers.tf
  ...

  provider "azurerm" {
    features {}

    tenant_id       = ""
    subscription_id = ""
    client_id       = ""
    client_secret   = ""
  }
  ...

  ```

- After initializing and connecting terraform to your Azure Account plan and apply the terraform code to deploy all resources to the cloud.
  
  ```shell
  terraform plan

  terraform apply #-auto-approve
  ```

## Demo Environment

- Hub and Spoke topology shall be showcased with the demo. A hub vnet and mulitple spoke vnets will be created based on the `vnet_spoke_list` in `locals.tf`. Refer to `_networks.tf`.
- Nework Manager resource is created with `AzApi` as there is no terraform provider available yet. The Network Manager contains the envelope and creates two `network groups` in `_manager.tf`. Please configure all other features in the Azure Portal.

## Usefule Documentation Links

- [Azure Docs](https://learn.microsoft.com/en-us/azure/virtual-network-manager/)
- [Simple and Central Azure Virtual Network Management Using the New AVNM](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/simple-and-central-azure-virtual-network-management-using-the/ba-p/3019384)
- [Securing Your Virtual Networks with AVNM](https://techcommunity.microsoft.com/t5/azure-networking-blog/securing-your-virtual-networks-with-azure-virtual-network/ba-p/3353366)
- [Pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-network-manager/)