variable "prefix" {
  type    = string
  default = "ieh"
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "lange3_sub_id" {
  default     = "188e0699-f2d6-435d-9841-150de64f96ee"
  description = "VSE-MPN-LANGE_3 Subscription."
}
variable "lange4_sub_id" {
  default     = "89e377bb-74d6-4f35-972c-dd77975d50f3"
  description = "VSE-MPN-LANGE_4 Subscription."
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "vnet" {
  type        = list(string)
  default     = ["10.150.0.0/16"]
  description = "Virtual Network"
}

variable "vnet_l3" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "Virtual Network"
}

variable "db_subnet" {
  type        = list(string)
  default     = ["10.150.100.0/24"]
  description = "DB subnet"
}

variable "web_subnet" {
  type        = list(string)
  default     = ["10.150.200.0/24"]
  description = "WEB App subnet"
}

variable "powerbi_subnet" {
  type        = list(string)
  default     = ["10.150.115.0/24"]
  description = "PowerBI subnet"
}

variable "fw_subnet" {
  type        = list(string)
  default     = ["10.150.150.0/24"]
  description = "FW subnet"
}

variable "ba_subnet" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "Bastion subnet"
}

variable "vpn_subnet" {
  type        = list(string)
  default     = ["10.150.250.0/24"]
  description = "VPN subnet"
}

variable "vpn_subnet_l3" {
  type        = list(string)
  default     = ["192.168.250.0/24"]
  description = "VPN subnet"
}

variable "vm_l3_subnet" {
  type        = list(string)
  default     = ["192.168.1.0/24"]
  description = "VM L3 subnet"
}
