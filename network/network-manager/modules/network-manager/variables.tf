variable "name" {
    description = "Name of the Virtual Network Subnet."
    type        = string
}

variable "subscription_id" {
    description = "Id of the Subscription."
    type        = string
}

variable "rg_id" {
    description = "Id of the Resource Group."
    type        = string
}

variable "location" {
    description = "Location of the Virtual Network."
    type        = string
}

variable "network_group_name_01" {
    description = "Name of the Virtual Network Group 01."
    type        = string
}

variable "network_group_name_02" {
    description = "Name of the Virtual Network Group 02."
    type        = string
}

# variable "address_space" {
#     description = "Address Space of Virtual Network."  
#     type        = list(string)
# }


# variable "nsg" {
#     description = "Conditional value for creation."  
#     type        = bool
#     default     = false
# }

# variable "tags" {
#     description = "Tags to set on the bucket."
#     type        = map(string)
#     default     = {}
# }
