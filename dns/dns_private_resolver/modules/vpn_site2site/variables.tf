variable "rg_name" {
    description = "Name of the Resource Group."
    type        = string
}

variable "location" {
    description = "Location of the Virtual Network."
    type        = string
}

variable "peer_vpn_gateway" {
    description = "Name of peered VPN Gateway."  
    type        = string
}

variable "peer_subnet_address_spaces" {
    description = "Address Space of peered network."
    type        = list(string)
}

variable "vnet_gwy_name" {
    description = "Name of VNet Gateway."
    type        = string
}

variable "subnet_id" {
    description = "Id of Gateway Subnet."
    type        = string 
}

variable "tags" {
    description = "Tags to set on the bucket."
    type        = map(string)
    default     = {}
}
