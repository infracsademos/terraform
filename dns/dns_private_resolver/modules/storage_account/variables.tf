variable "name" {
    description = "Name of the Storage Account."
    type        = string
}

variable "rg_name" {
    description = "Name of the Resource Group."
    type        = string
}

variable "location" {
    description = "Location of the Storage Account."
    type        = string
}

variable "tags" {
    description = "Tags to set on the bucket."
    type        = map(string)
    default     = {}
}

# variable "start" {
#     description = "Start time for the SAS token."
#     type        = string
#     default     = "2022-08-21T00:00:00Z"
# }
  
# variable "expiry" {
#     description = "Expiry time for the SAS token."
#     type        = string
#     default     = "2024-03-21T00:00:00Z"
# }
  
