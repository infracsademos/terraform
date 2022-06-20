variable "name" {
    description = "Name of the Virtual Network Subnet."
    type        = string
}

variable "vnet_name" {
    description = "Name of the Virtual Network."
    type        = string
}

variable "rg_name" {
    description = "Name of the Resource Group."
    type        = string
}

variable "address_space" {
    description = "Address Space of Virtual Network."  
    type        = list(string)
}

variable "nsg_id" {
    description = "Identifier of Network Security Group."  
    type        = string
    default     = "0"
}

variable "nsg_association" {
    description = "Conditional value for creation."  
    type        = bool
    default     = false
}

variable "tags" {
    description = "Tags to set on the bucket."
    type        = map(string)
    default     = {}
}
