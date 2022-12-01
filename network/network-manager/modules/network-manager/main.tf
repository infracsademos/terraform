#############################
###     Network Manager
#############################

resource "azapi_resource" "avnm" {
    type      = "Microsoft.Network/networkManagers@2022-04-01-preview"
    parent_id = var.rg_id
    name      = var.name
    location  = var.location
    body = jsonencode({
        properties = {
            networkManagerScopeAccesses = ["Connectivity", "SecurityAdmin"]
            networkManagerScopes = {
                subscriptions = [var.subscription_id]
            }
        }
    })
}


#############################
###     Network Group
#############################

resource "azapi_resource" "avnmng_01" {
    type      = "Microsoft.Network/networkManagers/networkGroups@2022-04-01-preview"
    name      = var.network_group_name_01
    parent_id = azapi_resource.avnm.id
    body = jsonencode({
        properties = {
            description = "All Network Group with all VNets.",
            memberType = "VirtualNetwork"
        }
    })
    # depends_on = [
    #     azurerm_virtual_network.vnet
    # ]
}

resource "azapi_resource" "avnmng_02" {
    type      = "Microsoft.Network/networkManagers/networkGroups@2022-04-01-preview"
    name      = var.network_group_name_02
    parent_id = azapi_resource.avnm.id
    body = jsonencode({
        properties = {
            description = "Dedicated Network Group with specficic VNets.",
            memberType = "VirtualNetwork"
        }
    })
    # depends_on = [
    #     azurerm_virtual_network.vnet
    # ]
}

# ### Network group members - add for_each
# resource "azapi_resource" "ngmember1" {
#   type      = "Microsoft.Network/networkManagers/networkGroups/staticMembers@2022-05-01"
#   name      = "ng100"
#   parent_id = azapi_resource.vnetnmng.id
#   body = jsonencode({
#     properties = {
#       resourceId = azurerm_virtual_network.vnet[1].id
#     }
#   })
# }

# resource "azapi_resource" "ngmember2" {
#   type      = "Microsoft.Network/networkManagers/networkGroups/staticMembers@2022-05-01"
#   name      = "ng101"
#   parent_id = azapi_resource.vnetnmng.id
#   body = jsonencode({
#     properties = {
#       resourceId = azurerm_virtual_network.vnet[2].id
#     }
#   })
# }

# ### Connectivity Configuration
# resource "azapi_resource" "avnmconnectivity" {
#   type      = "Microsoft.Network/networkManagers/connectivityConfigurations@2022-05-01"
#   name      = "connectivity"
#   parent_id = azapi_resource.vnetnm.id
#   body = jsonencode({
#     properties = {
#       appliesToGroups = [
#         {
#           groupConnectivity = "DirectlyConnected"
#           isGlobal          = "True" // In a sense that allow global communication between spokes
#           networkGroupId    = azapi_resource.vnetnmng.id
#           useHubGateway     = "False"
#         }
#       ]
#       connectivityTopology  = "HubAndSpoke"
#       deleteExistingPeering = "True"
#       description           = "Connection Configuration"
#       hubs = [
#         {
#           resourceId   = azurerm_virtual_network.vnet[0].id
#           resourceType = "Microsoft.Network/virtualNetworks"
#         }
#       ]

#       isGlobal = "False" //in a sense enable mesh global connectivity
#     }
#   })
# }

# ### Security Admin Configuration
# resource "azapi_resource" "avnmsc" {
#   type      = "Microsoft.Network/networkManagers/securityAdminConfigurations@2022-05-01"
#   name      = "secconfig"
#   parent_id = azapi_resource.vnetnm.id
#   body = jsonencode({
#     properties = {
#       applyOnNetworkIntentPolicyBasedServices = ["AllowRulesOnly"] //All require subscription option registration - for now use AllowRulesOnly or None 
#       description                             = "SecurityConfig"
#     }
#   })
# }

# ### Create rule collection
# resource "azapi_resource" "secrulecollection" {
#   type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections@2022-05-01"
#   name      = "SecurityRuleCollection"
#   parent_id = azapi_resource.avnmsc.id
#   body = jsonencode({
#     properties = {
#       appliesToGroups = [
#         {
#           networkGroupId = azapi_resource.vnetnmng.id
#         }
#       ]
#       description = "Security Rule Collection"
#     }
#   })
# }

# resource "azapi_resource" "securityrule" {
#   type      = "Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2022-05-01"
#   name      = "SSH_Access"
#   parent_id = azapi_resource.secrulecollection.id
#   body = jsonencode({
#     name = "SSH_Access" // not required by Azure but terraform needs it
#     kind = "Custom"     // Custom or default
#     properties = {
#       access                = "Allow" // In Azure called action - Allow, AlwaysAllow, Deny
#       description           = "Allow SSH"
#       destinationPortRanges = ["22"]
#       destinations = [
#         {
#           addressPrefix     = "*"        // Destination address with Inbound connection does not need to be specified
#           addressPrefixType = "IPPrefix" // Choose IPPrefix or ServiceTag
#         }
#       ]
#       direction = "Inbound" //Inbound or Outbound
#       priority  = 1001
#       protocol  = "Tcp"
#       sourcePortRanges = [
#         "0-65535" // to allow all
#       ]
#       sources = [
#         {
#           addressPrefix     = "*"
#           addressPrefixType = "IPPrefix" // Choose IPPrefix or ServiceTag
#         }
#       ]
#     }
#   })
# }