resource "azurerm_virtual_wan" "vwan" {
    name                = var.name
    resource_group_name = var.rg_name
    location            = var.location

    type                = "Standard"
}

resource "azurerm_virtual_hub" "hub-001" {
  name                  = var.hub-001_name
  resource_group_name   = azurerm_virtual_wan.vwan.resource_group_name
  location              = azurerm_virtual_wan.vwan.location
  virtual_wan_id        = azurerm_virtual_wan.vwan.id
  address_prefix        = "10.0.0.0/24"
}