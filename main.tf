module "resource-group" {
  count                   = var.resource_group_name == "" ? 0 : length(var.resource_group_name) 
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  version                 = "0.0.1"
  resource_group_name     = element(var.resource_group_name, count.index)
  resource_group_location = var.resource_group_location
  lock_level_value        = var.lock_level_value
  tag_map = merge(
    {
      "Name" = element(var.resource_group_name, count.index)
    },
    var.tags,
  )
}


module "virtual-network" {
  count                       = var.vnet_name == "" ? 0 : length(var.vnet_name) 
  source                      = "OT-terraform-azure-modules/virtual-network/azure"
  version                     = "0.0.2"
  depends_on                  = [module.resource-group]
  resource_group_name         = element(var.resource_group_name, count.index)
  resource_group_location     = element(var.vnet_location, count.index)
  address_space               = element(var.address_space, count.index)
  vnet_name                   = element(var.vnet_name, count.index)
  dns_servers                 = var.dns_servers
  create_ddos_protection_plan = element(var.create_ddos_protection_plan, count.index)
  tag_map = merge(
    {
      "Name" = element(var.resource_group_name, count.index)
    },
    var.tags,
  )
}


module "subnet" {
  count                   = var.subnet_name == "" ? 0 : length(var.subnet_name)
  source                  = "OT-terraform-azure-modules/subnet/azure"
  version                 = "0.0.2"
  depends_on              = [module.virtual-network]
  resource_group_name     = element(var.resource_group_name, count.index)
  vnet_name               = element(var.vnet_name, count.index)
  subnet_name             = element(var.subnet_name, count.index)
  subnet_address_prefixes = element(var.subnet_address_prefixes, count.index)
  service_endpoints       = var.service_endpoints
}

module "vm_module" {
  source                         = "git::https://github.com/OT-terraform-azure-modules/terraform-azure-virtual-machine.git?ref=feature-1.0.0"
  count                          = var.vm_name == "" ? 0 : length(var.vm_name)
  nic_ip_configuration_subnet_id = module.subnet[0].subnet_id[0]
  name                           = element(var.vm_name, count.index)
  resource_group_name            = element(var.resource_group_name, count.index)
  location                       = element(var.vnet_location, count.index)
  vm_size                        = var.vm_size
  storage_image_reference        = var.vm_storage_image_reference_1
  storage_os_disk                = element(var.vm_storage_os_disk, count.index)
  os_profile                     = var.vm_os_profile
  public_key                     = file("~/.ssh/id_rsa.pub")
  
  tagMap = merge(
    {
      "Name" = element(var.vm_name, count.index)
    },
    var.tags,
  )

  os_profile_linux_config = {
    disable_password_authentication = true
    ssh_keys = {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

}

module "nsg_vm_module" {
  source                              = "git::https://github.com/OT-terraform-azure-modules/terraform-azure-network-security-group.git?ref=v1.0"
  azurem_security_group_name          = var.azurem_security_group_name
  azurerm_resource_group_nsg_location = module.resource-group[0].resource_group_location
  azurerm_resource_group_nsg_name     = module.resource-group[0].resource_group_name
  azurem_custom_nsg_rules             = var.azurem_custom_nsg_rules
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  count                          = var.vm_name == "" ? 0 : length(var.vm_name)
  network_interface_id      = module.vm_module[count.index].nic_id
  network_security_group_id = module.nsg_vm_module.azurerm_nsg_id[count.index]
}
