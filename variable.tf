/*------------------Resource group variable -----------*/
variable "resource_group_name" {
  type        = list(string)
  description = "(Required) Name of Resource Group"
}

variable "resource_group_location" {
  type        = string
  description = "(Required) Location where we want to implement code"
}

variable "lock_level_value" {
  type        = string
  default     = "CanNotDelete"
  description = "(Required) Specifies the Level to be used for this Lock. Possible values are `Empty (no lock)`, `CanNotDelete` and `ReadOnly`. Changing this forces a new resource to be created"
}

/*------------------Vnet variable -----------*/
variable "vnet_name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = list(string)
}

variable "vnet_location" {
  type        = list(string)
  description = "names of the vnet's location"

}

variable "address_space" {
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
  type        = list(list(any))
}

variable "create_ddos_protection_plan" {
  description = "(Required) Create an ddos plan - Default is false"
  type        = list(bool)
  default     = [false]
}

variable "dns_servers" {
  description = "(Optional) List of IP addresses of DNS servers"
  type        = list(string)
}

# /*------------------Subnet variable -----------*/
variable "subnet_name" {
  description = "The variable for subnet names"
  type        = list(list(string))
}

variable "subnet_address_prefixes" {
  description = "The CIDR block for the vnet"
  type        = list(list(string))
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet"
  type        = list(string)
}


variable "tags" {
   type        = map(string)
   description = "Map of Tags those we want to Add"
}
