resource "azurerm_vpn_site" "res-36" {
  address_cidrs       = ["10.5.0.0/28"]
  device_vendor       = "Cisco"
  location            = "eastus"
  name                = "demo-site01"
  resource_group_name = "rg-vwan"
  virtual_wan_id      = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualWans/vwan-demo"
  link {
    ip_address    = "52.191.35.94"
    name          = "demolink01"
    provider_name = "Azure"
    speed_in_mbps = 50
  }
  depends_on = [
    azurerm_virtual_wan.res-14,
  ]
}
resource "azurerm_virtual_network_gateway_connection" "res-38" {
  authorization_key               = null # sensitive
  express_route_circuit_id        = null
  local_network_gateway_id        = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/localNetworkGateways/vwan-hub-eastus-01"
  location                        = "eastus"
  name                            = "connection01"
  peer_virtual_network_gateway_id = null
  resource_group_name             = "rg-vwan"
  shared_key                      = null # sensitive
  type                            = "IPsec"
  virtual_network_gateway_id      = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworkGateways/vnetgwy-onprem"
  depends_on = [
    azurerm_virtual_network_gateway.res-44,
    azurerm_local_network_gateway.res-2,
  ]
}
resource "azurerm_subnet" "res-48" {
  name                 = "subnet-hub01-spoke-default"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-hub01-spoke"
  depends_on = [
    azurerm_virtual_network.vnet-hub01-spoke01,
    azurerm_route_table.res-11,
  ]
}
resource "azurerm_virtual_wan" "res-14" {
  location            = "eastus"
  name                = "vwan-demo"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_security_rule" "res-22" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH"
  network_security_group_name = "vm-hub01-spoke-nsg"
  priority                    = 300
  protocol                    = "TCP"
  resource_group_name         = "rg-vwan"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-6,
  ]
}
resource "azurerm_network_security_rule" "res-23" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH"
  network_security_group_name = "vm-hub01-test-nsg"
  priority                    = 300
  protocol                    = "TCP"
  resource_group_name         = "rg-vwan"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-7,
  ]
}

resource "azurerm_firewall_policy" "res-0" {
  location            = "eastus"
  name                = "firewallpoliciy-hub01"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_security_group" "res-5" {
  location            = "eastus"
  name                = "vm-hub01-spoke-new-nsg"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_interface" "res-39" {
  location            = "eastus"
  name                = "vm-hub01-spoke159"
  resource_group_name = "rg-vwan"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01-spoke/subnets/subnet-hub01-spoke-default"
  }
  depends_on = [
    azurerm_subnet.res-48,
    azurerm_network_security_group.res-6,
  ]
}


resource "azurerm_subnet" "res-49" {
  name                 = "default"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-hub01-spoke-new"
  depends_on = [
    azurerm_virtual_network.vnet-hub01-spoke02,
    azurerm_route_table.res-11,
  ]
}
resource "azurerm_local_network_gateway" "res-3" {
  gateway_address     = "20.124.153.15"
  location            = "eastus"
  name                = "vwan-hub-eastus02"
  resource_group_name = "rg-vwan"
  bgp_settings {
    asn                 = 65515
    bgp_peering_address = "10.0.0.13"
  }
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_security_group" "res-4" {
  location            = "eastus"
  name                = "vm01-onprem-nsg"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_public_ip" "res-10" {
  allocation_method   = "Dynamic"
  domain_name_label   = null
  location            = "eastus"
  name                = "vm01-onprem-ip"
  public_ip_prefix_id = null
  resource_group_name = "rg-vwan"
  reverse_fqdn        = null
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_security_group" "res-6" {
  location            = "eastus"
  name                = "vm-hub01-spoke-nsg"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}



resource "azurerm_virtual_hub" "res-42" {
  address_prefix      = "10.0.0.0/24"
  location            = "eastus"
  name                = "hub01"
  resource_group_name = "rg-vwan"
  sku                 = "Standard"
  virtual_wan_id      = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualWans/vwan-demo"
  depends_on = [
    azurerm_virtual_wan.res-14,
    azurerm_vpn_gateway.res-57,
  ]
}
resource "azurerm_virtual_hub" "res-25" {
  address_prefix      = "10.100.0.0/24"
  location            = "northeurope"
  name                = "hub02"
  resource_group_name = "rg-vwan"
  sku                 = "Standard"
  virtual_wan_id      = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualWans/vwan-demo"
  depends_on = [
    azurerm_virtual_wan.res-14,
  ]
}
resource "azurerm_local_network_gateway" "res-2" {
  gateway_address     = "20.124.153.12"
  location            = "eastus"
  name                = "vwan-hub-eastus-01"
  resource_group_name = "rg-vwan"
  bgp_settings {
    asn                 = 65515
    bgp_peering_address = "10.0.0.12"
  }
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_security_group" "res-7" {
  location            = "eastus"
  name                = "vm-hub01-test-nsg"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_subnet" "res-33" {
  name                 = "subnet-onprem"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-onprem"
  depends_on = [
    azurerm_virtual_network.res-13,
  ]
}
resource "azurerm_network_interface" "res-41" {
  location            = "eastus"
  name                = "vm-hub01-test578_z1"
  resource_group_name = "rg-vwan"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01/subnets/subnet-hub01-default"
  }
  depends_on = [
    azurerm_subnet.subnet-hub01-default,
    azurerm_network_security_group.res-7,
  ]
}
resource "azurerm_virtual_hub_connection" "res-59" {
  internet_security_enabled = true
  name                      = "hub02_vnet-hub01-northeu"
  remote_virtual_network_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01-northeu"
  virtual_hub_id            = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub02"
  depends_on = [
    azurerm_virtual_hub.res-25,
    azurerm_virtual_hub_route_table.res-27,
    azurerm_virtual_hub_route_table.res-43,
    azurerm_virtual_network.res-12,
  ]
}
resource "azurerm_route_table" "res-11" {
  location            = "eastus"
  name                = "rt-hub01"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_route" "res-24" {
  address_prefix         = "0.0.0.0/0"
  name                   = "RTSPOKEDEFAULT"
  next_hop_in_ip_address = "10.2.0.68"
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = "rg-vwan"
  route_table_name       = "rt-hub01"
  depends_on = [
    azurerm_route_table.res-11,
  ]
}
resource "azurerm_virtual_hub_route_table" "res-27" {
  labels         = ["default"]
  name           = "defaultRouteTable"
  virtual_hub_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub02"
  depends_on = [
    azurerm_virtual_hub.res-25,
  ]
}
resource "azurerm_virtual_hub_connection" "res-56" {
  internet_security_enabled = true
  name                      = "hub01_vnet-hub01"
  remote_virtual_network_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01"
  virtual_hub_id            = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub01"
  depends_on = [
    azurerm_virtual_hub.res-42,
    azurerm_virtual_hub_route_table.res-43,
    azurerm_virtual_network.vnet-hub01,
  ]
}
resource "azurerm_vpn_gateway_connection" "res-58" {
  name               = "Connection-vpnsite-onprem01"
  remote_vpn_site_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/vpnSites/vpnsite-onprem01"
  vpn_gateway_id     = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/vpnGateways/f62358dec8a344a9bad3044cb7a7102f-eastus-gw"
  vpn_link {
    bgp_enabled      = true
    name             = "onpremlink01"
    shared_key       = "judith123"
    vpn_site_link_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/vpnSites/vpnsite-onprem01/vpnSiteLinks/onpremlink01"
  }
  depends_on = [
    azurerm_vpn_gateway.res-57,
    azurerm_virtual_hub_route_table.res-43,
    azurerm_vpn_site.res-37,
  ]
}
resource "azurerm_virtual_network" "res-13" {
  address_space       = ["10.5.0.0/24"]
  location            = "eastus"
  name                = "vnet-onprem"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_network_security_rule" "res-20" {
  access                      = "Deny"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH"
  network_security_group_name = "vm01-onprem-nsg"
  priority                    = 300
  protocol                    = "TCP"
  resource_group_name         = "rg-vwan"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_virtual_network_gateway" "res-44" {
  default_local_network_gateway_id = null
  location                         = "eastus"
  name                             = "vnetgwy-onprem"
  resource_group_name              = "rg-vwan"
  sku                              = "VpnGw1"
  type                             = "Vpn"
  ip_configuration {
    name                 = "default"
    public_ip_address_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/publicIPAddresses/pip-vngwy"
    subnet_id            = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-onprem/subnets/GatewaySubnet"
  }
  depends_on = [
    azurerm_public_ip.res-9,
    azurerm_subnet.res-32,
  ]
}
resource "azurerm_virtual_network" "res-12" {
  address_space       = ["10.3.0.0/24"]
  location            = "northeurope"
  name                = "vnet-hub01-northeu"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_subnet" "res-32" {
  name                 = "GatewaySubnet"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-onprem"
  depends_on = [
    azurerm_virtual_network.res-13,
  ]
}
resource "azurerm_vpn_site" "res-37" {
  device_vendor       = "Cisco"
  location            = "eastus"
  name                = "vpnsite-onprem01"
  resource_group_name = "rg-vwan"
  virtual_wan_id      = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualWans/vwan-demo"
  link {
    ip_address    = "20.231.39.61"
    name          = "onpremlink01"
    provider_name = "Azure"
    speed_in_mbps = 50
    bgp {
      asn             = 65000
      peering_address = "10.5.0.254"
    }
  }
  depends_on = [
    azurerm_virtual_wan.res-14,
  ]
}
resource "azurerm_public_ip" "res-8" {
  allocation_method   = "Static"
  domain_name_label   = null
  location            = "eastus"
  name                = "pip-hub01"
  public_ip_prefix_id = null
  resource_group_name = "rg-vwan"
  reverse_fqdn        = null
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}

resource "azurerm_network_interface" "res-55" {
  location            = "eastus"
  name                = "vm01-onprem594"
  resource_group_name = "rg-vwan"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/publicIPAddresses/vm01-onprem-ip"
    subnet_id                     = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-onprem/subnets/subnet-onprem"
  }
  depends_on = [
    azurerm_public_ip.res-10,
    azurerm_subnet.res-33,
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_subnet" "res-31" {
  name                 = "default"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-hub01-northeu"
  depends_on = [
    azurerm_virtual_network.res-12,
  ]
}
resource "azurerm_virtual_network_peering" "res-34" {
  name                      = "RemoteVnetToHubPeering_2943d591-5557-47dd-aedc-ac1564b09909"
  remote_virtual_network_id = "/subscriptions/63a13922-f9b7-44ad-800a-87b84ce622d3/resourceGroups/RG_hub01_33e8a688-6e34-4fce-8af6-5db929a73890/providers/Microsoft.Network/virtualNetworks/HV_hub01_b48f56c5-f434-4b78-850b-684f3017b53b"
  resource_group_name       = "rg-vwan"
  virtual_network_name      = "vnet-hub01"
  depends_on = [
    azurerm_virtual_network.vnet-hub01,
  ]
}
resource "azurerm_virtual_hub_route_table" "res-43" {
  labels         = ["default"]
  name           = "defaultRouteTable"
  virtual_hub_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub01"
  depends_on = [
    azurerm_virtual_hub.res-42,
    azurerm_virtual_hub_connection.res-56,
  ]
}
resource "azurerm_virtual_network_peering" "res-35" {
  name                      = "RemoteVnetToHubPeering_6f28a4db-ad79-4707-b3f7-518eeba03bc4"
  remote_virtual_network_id = "/subscriptions/ecaf634f-769f-44a3-9089-9ece03d05862/resourceGroups/RG_hub02_2f18c47d-3057-433d-b821-429e88c41526/providers/Microsoft.Network/virtualNetworks/HV_hub02_7153a385-1b93-44f1-9e94-8b9d17779c91"
  resource_group_name       = "rg-vwan"
  virtual_network_name      = "vnet-hub01-northeu"
  depends_on = [
    azurerm_virtual_network.res-12,
  ]
}
resource "azurerm_resource_group" "res-60" {
  location = "eastus"
  name     = "rg-vwan"
}
resource "azurerm_public_ip" "res-9" {
  allocation_method   = "Static"
  domain_name_label   = null
  location            = "eastus"
  name                = "pip-vngwy"
  public_ip_prefix_id = null
  resource_group_name = "rg-vwan"
  reverse_fqdn        = null
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_virtual_hub_route_table" "res-26" {
  labels         = ["none"]
  name           = "noneRouteTable"
  virtual_hub_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub01"
  depends_on = [
    azurerm_virtual_hub.res-42,
  ]
}
resource "azurerm_network_security_rule" "res-21" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH"
  network_security_group_name = "vm-hub01-spoke-new-nsg"
  priority                    = 300
  protocol                    = "TCP"
  resource_group_name         = "rg-vwan"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}

resource "azurerm_network_interface" "res-40" {
  location            = "eastus"
  name                = "vm-hub01-spoke-ne281"
  resource_group_name = "rg-vwan"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01-spoke-new/subnets/default"
  }
  depends_on = [
    azurerm_subnet.res-49,
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_vpn_gateway" "res-57" {
  location            = "eastus"
  name                = "f62358dec8a344a9bad3044cb7a7102f-eastus-gw"
  resource_group_name = "rg-vwan"
  virtual_hub_id      = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub01"
  depends_on = [
    azurerm_virtual_hub_route_table.res-43,
    azurerm_vpn_site.res-37,
    azurerm_virtual_hub.res-42,
  ]
}
resource "azurerm_local_network_gateway" "res-1" {
  address_space       = ["10.5.0.0/24"]
  gateway_address     = "20.124.153.12"
  location            = "eastus"
  name                = "gwy-onprem"
  resource_group_name = "rg-vwan"
  bgp_settings {
    asn                 = 65515
    bgp_peering_address = "10.0.0.12"
  }
  depends_on = [
    azurerm_resource_group.res-60,
  ]
}
resource "azurerm_firewall_policy_rule_collection_group" "res-19" {
  firewall_policy_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/firewallPolicies/firewallpoliciy-hub01"
  name               = "DefaultNetworkRuleCollectionGroup"
  priority           = 200
  network_rule_collection {
    action   = "Allow"
    name     = "RTTOHUB"
    priority = 100
    rule {
      destination_addresses = ["10.2.2.0/24"]
      destination_ports     = ["22", "80", "8000-9000"]
      name                  = "AllowAny"
      protocols             = ["Any"]
      source_addresses      = ["10.5.0.0/24"]
    }
    rule {
      destination_addresses = ["10.6.0.0/24"]
      destination_ports     = ["22", "80", "8000-9000"]
      name                  = "OnPremToSpokeNew"
      protocols             = ["Any"]
      source_addresses      = ["10.5.0.0/24"]
    }
  }
  depends_on = [
    azurerm_firewall_policy.res-0,
  ]
}
resource "azurerm_virtual_hub_route_table" "res-28" {
  labels         = ["none"]
  name           = "noneRouteTable"
  virtual_hub_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualHubs/hub02"
  depends_on = [
    azurerm_virtual_hub.res-25,
  ]
}