resource "azurerm_public_ip" "pip_apgw" {
  name                = "pip-apgw"
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.rg_apgw.name
  location            = azurerm_resource_group.rg_apgw.location
  allocation_method   = "Static"
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet_westeu_01.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet_westeu_01.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet_westeu_01.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet_westeu_01.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet_westeu_01.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet_westeu_01.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.vnet_westeu_01.name}-rdrcfg"
}


resource "azurerm_application_gateway" "apgw" {
  name                = "apgw-prod-01"
  resource_group_name = azurerm_resource_group.rg_apgw.name
  location            = azurerm_resource_group.rg_apgw.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "apgw-prod-01-ip-configuration"
    subnet_id = azurerm_subnet.snet_apgw.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip_apgw.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 10
  }
}


resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "backend_vm" {
  network_interface_id    = azurerm_network_interface.nic_vm_backend.id
  ip_configuration_name   = "ipconfig-vm-backend"
  //backend_address_pool_id = azurerm_application_gateway.apgw.backend_address_pool[0].id
  backend_address_pool_id = [for value in tolist(azurerm_application_gateway.apgw.backend_address_pool.*.id) : value if length(regexall(lower(local.backend_address_pool_name), value)) > 0][0]
}