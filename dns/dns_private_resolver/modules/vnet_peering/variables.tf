variable "vnet_name" {
    description = "Name of the Virtual Network."
    type        = string
}

variable "rg_name" {
    description = "Name of the Resource Group."
    type        = string
}

variable "remote_vnet_name" {
    description = "Name of the Virtual Network to be peered."
    type        = string
    default     = "value"
}

variable "remote_vnet_id" {
    description = "Id of the Virtual Network to be peered."
    type        = string
    default     = "value"
}

variable "allow_gateway_transit" {
    description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."  
    type        = bool
    default     = false
}

variable "use_remote_gateways" {
    description = "Controls if remote gateways can be used on the local virtual network."  
    type        = bool
    default     = false
}

variable "tags" {
    description = "Tags to set on the bucket."
    type        = map(string)
    default     = {}
}
