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



## vm 

variable "vm_name" {
  description = "Provide vm Name"
  type        = list(string)
}


variable "vm_size" {
  description = "Specifies the VM Size"
  type        = string
}


variable "vm_storage_image_reference_1" {
  type        = any
  description = "Specifies the VM image"
}

variable "vm_storage_os_disk" {
  type        = any
  description = "Specifies the VM storage disk"
  default = [{
    name              = "vmdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    },
    {
      name              = "vmdisk2"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
  }]
}



variable "vm_os_profile" {
  type        = any
  description = "Specifies the VM user and profile"
  default = {
    computer_name  = "hostname"
    admin_username = "ubuntu"
    admin_password = null

  }
}

#-----------------nsg----
variable "azurem_security_group_name" {
  description = "nsg_name"
  type        = list(string)
}

variable "azurem_custom_nsg_rules" {
  type = list(object({
    name                       = list(string)
    priority                   = list(number)
    direction                  = list(string)
    access                     = list(string)
    protocol                   = list(string)
    source_port_range          = list(string)
    destination_port_range     = list(string)
    source_address_prefix      = list(string)
    destination_address_prefix = list(string)
  }))
  description = "security_rule"
}



