# Public IP Address
resource "azurerm_public_ip" "bastion" {
  name                = "pip-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}


# Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  public_ip_address_id = azurerm_public_ip.bastion.id
  virtual_network_subnet_id = azure_subnet.subnet_bastion_host.id
}
