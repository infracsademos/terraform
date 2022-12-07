resource "azurerm_public_ip" "pip_firewall" {
  name                = "pip-firewall"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = var.sku_name
  sku_tier            = var.sku
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pip_firewall.id
  }
}


resource "azurerm_firewall_policy" "firewall_policy" {
  name                = "example-fwpolicy"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Premium"
}


resource "azurerm_firewall_policy_rule_collection_group" "policy_group" {
  name               = "example-fwpolicy-rcg"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = 500
  application_rule_collection {
    name     = "app_rule_collection1"
    priority = 500
    action   = "Allow"
    rule {
      name = "app_rule_collection1_rule1"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["*"]
      destination_fqdns = ["*"]
    }
  }

  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 400
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}