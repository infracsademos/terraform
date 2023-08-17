#### Enable public IP if needed ######
resource "azurerm_public_ip" "pip_apgw" {
  name                = "pip-apgw"
  sku                 = "Standard"
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
}


# local block for variables
locals {
  backend_address_pool_name      = "apgw-beap"
  frontend_port_name             = "apgw-feport"
  frontend_ip_configuration_name = "apgw-feip"
  http_setting_name              = "apgw-be-htst"
  listener_name                  = "apgw-httplstn"
  request_routing_rule_name      = "apgw-rqrt"
  redirect_configuration_name    = "apgw-rdrcfg"
}


resource "azurerm_application_gateway" "apgw" {
  name                = "apgw-prod-01"
  resource_group_name = var.rg_name
  location            = var.rg_location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = "1"
    max_capacity = "4"
  }

  gateway_ip_configuration {
    name      = "apgw-prod-01-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip_apgw.id
  }

   frontend_ip_configuration {
    name                                 = "${local.frontend_ip_configuration_name}-private"
    subnet_id                            = var.subnet_id
    private_ip_address_allocation        = "Static"
    private_ip_address                   = "10.3.2.50"
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