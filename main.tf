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
  # create_ddos_protection_plan = element(var.create_ddos_protection_plan, count.index)
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