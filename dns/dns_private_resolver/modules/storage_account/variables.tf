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