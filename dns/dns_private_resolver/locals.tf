locals {
    rg_name                 = "rg-ic-learning"
    location                = "westeurope"

    #### ONPREM_001
    vnet_onprem_001              = "vnet-onprem-${local.location}-001"
    vgw_onprem_001               = "vgw-onprem-${local.location}-001"
    lgw_onprem_001               = "lgw-onprem-${local.location}-001"
    as_onprem_001_vnet           = ["10.1.0.0/16"]
    as_onprem_001_snet_default   = ["10.1.0.0/24"]
    as_onprem_001_snet_gw        = ["10.1.1.0/24"]
    as_onprem_001_snet_bastion   = ["10.1.2.0/24"]
    bas_onprem_001               = "bas-onprem-001"
    pip_bas_onprem_001           = "pip-${local.bas_onprem_001}"

    #### HUB_001
    vnet_hub_001            = "vnet-hub-${local.location}-001"
    snet_pdre_i             = "snet-pdre-i"
    snet_pdre_o             = "snet-pdre-o"
    vgw_hub_001             = "vgw-hub-${local.location}-001"
    lgw_hub_001             = "lgw-hub-${local.location}-001"
    as_hub_001_vnet         = ["10.2.0.0/16"]
    as_hub_001_snet_default = ["10.2.0.0/24"]
    as_hub_001_snet_pdre_i  = ["10.2.1.0/28"]
    as_hub_001_snet_pdre_o  = ["10.2.2.0/28"]
    as_hub_001_snet_gw      = ["10.2.3.0/24"]
    as_hub_001_snet_bastion = ["10.2.4.0/24"]
    as_hub_001_snet_firewall= ["10.2.5.0/24"]
    bas_hub_001             = "bas-hub-001"
    pip_bas_hub_001         = "pip-${local.bas_hub_001}"

    #### SPOKE_001
    vnet_spoke_001              = "vnet-spoke-${local.location}-001"
    as_spoke_001_vnet           = ["10.3.0.0/16"]
    as_spoke_001_snet_default   = ["10.3.0.0/24"]
    as_spoke_001_snet_bastion   = ["10.3.1.0/24"]
    as_spoke_001_snet_apgw      = ["10.3.2.0/24"]
    bas_spoke_001               = "bas-spoke-001"
    pip_bas_spoke_001           = "pip-${local.bas_spoke_001}"

    #### SUBNETS
    snet_default            = "snet-default"
    snet_gw                 = "GatewaySubnet"
    snet_bastion            = "AzureBastionSubnet"
    snet_firewall           = "AzureFirewallSubnet"
    snet_apgw               = "snet-apgw"

    ### UTILS
    config_storage          = "saiclconfig"
}   