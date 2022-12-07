resource "azurerm_route_table" "route_table" {
  name                          = var.rt_name
  location                      = var.location
  resource_group_name           = var.rg_name
  disable_bgp_route_propagation = false

  route {
    name                    = var.route_name
    address_prefix          = var.address_prefix
    next_hop_type           = var.next_hop_type
    next_hop_in_ip_address  = var.next_hop_in_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}