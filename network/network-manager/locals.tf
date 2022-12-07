locals {
    rg_name             = "rg-avnm-demo"

    base_vnet_name      = "vnet-avnm-demo"
    base_snet_name      = "snet"

    location_weu        = "weu"
    location_eus        = "eus" 

    location_westeurope = "westeurope"
    location_eastus     = "eastus"

    vnet_hub_001_name   = "${local.base_vnet_name}-${local.location_weu}-hub"
    vnet_hub_001_range  = ["10.0.0.0/16"]
    snet_hub_001_name   = "${local.base_snet_name}-001"
    snet_hub_001_range  = ["10.0.1.0/24"]

    vnet_spoke_list = [
        {
            location    = local.location_westeurope
            vnet_name   = "${local.base_vnet_name}-${local.location_weu}-001",
            vnet_range  = ["10.1.0.0/16"],
            snet_name   = "${local.base_snet_name}-001",
            snet_range  = ["10.1.1.0/24"]
        },
        {
            location    = local.location_westeurope
            vnet_name   = "${local.base_vnet_name}-${local.location_weu}-002",
            vnet_range  = ["10.2.0.0/16"],
            snet_name   = "${local.base_snet_name}-001",
            snet_range  = ["10.2.1.0/24"]
        },
        {
            location    = local.location_westeurope
            vnet_name   = "${local.base_vnet_name}-${local.location_weu}-003",
            vnet_range  = ["10.3.0.0/16"],
            snet_name   = "${local.base_snet_name}-001",
            snet_range  = ["10.3.1.0/24"]
        },
        {
            location    = local.location_eastus
            vnet_name   = "${local.base_vnet_name}-${local.location_eus}-004",
            vnet_range  = ["10.4.0.0/16"],
            snet_name   = "${local.base_snet_name}-001",
            snet_range  = ["10.4.1.0/24"]
        },
        {
            location    = local.location_eastus
            vnet_name   = "${local.base_vnet_name}-${local.location_eus}-004-dupl",
            vnet_range  = ["10.4.0.0/16"],
            snet_name   = "${local.base_snet_name}-001",
            snet_range  = ["10.4.1.0/24"]
        }
    ]

    subscription_id         = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1"
    avnm_name               = "avnm-demo"
    network_group_name_01   = "all-ng"
    network_group_name_02   = "app-01-ng"
}