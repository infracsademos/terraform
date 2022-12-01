# https://registry.terraform.io/providers/azure/azapi/latest/docs

resource "azapi_resource" "testresolver" {
  type      = "Microsoft.Network/dnsResolvers@2020-04-01-preview"
  name      = "testresolver"
  parent_id = data.azurerm_resource_group.rg.id
  location  = data.azurerm_resource_group.rg.location

  body = jsonencode({
    properties = {
      virtualNetwork = {
        id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-dns-azapi/providers/Microsoft.Network/virtualNetworks/vnet-dns"
      }
    }
  })

  response_export_values = ["properties.virtualnetwork.id"]
}

resource "azapi_resource" "inboundendpoint" {
  type      = "Microsoft.Network/dnsResolvers/inboundEndpoints@2020-04-01-preview"
  name      = "inboundendpoint"
  parent_id = azapi_resource.testresolver.id
  location  = azapi_resource.testresolver.location

  body = jsonencode({
    properties = {
      ipConfigurations = [{ subnet = { id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-dns-azapi/providers/Microsoft.Network/virtualNetworks/vnet-dns/subnets/dns-inbound" } }]
    }
  })

  response_export_values = ["properties.ipconfiguration"]
  depends_on = [
    azapi_resource.testresolver
  ]
}

resource "azapi_resource" "outboundendpoint" {
  type      = "Microsoft.Network/dnsResolvers/outboundEndpoints@2020-04-01-preview"
  name      = "outboundendpoint"
  parent_id = azapi_resource.testresolver.id
  location  = azapi_resource.testresolver.location

  body = jsonencode({
    properties = {
      subnet = {
        id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-dns-azapi/providers/Microsoft.Network/virtualNetworks/vnet-dns/subnets/dns-outbound"
      }
    }
  })

  response_export_values = ["properties.subnet"]
  depends_on = [
    azapi_resource.testresolver
  ]
}

resource "azapi_resource" "ruleset" {
  type      = "Microsoft.Network/dnsForwardingRulesets@2020-04-01-preview"
  name      = "testruleset"
  parent_id = data.azurerm_resource_group.rg.id
  location  = data.azurerm_resource_group.rg.location

  body = jsonencode({
    properties = {
      dnsResolverOutboundEndpoints = [{
        id = azapi_resource.outboundendpoint.id
      }]
    }
  })
  depends_on = [
    azapi_resource.testresolver
  ]
}