output "resource_group_location" {
  value       = module.resource-group[*].resource_group_location
  description = "Location of the Resource Group Provisioned"
}


output "resource_group_name" {
  value       = module.resource-group[*].resource_group_name
  description = "Name of the Resource Group Provisioned"
}

output "vnet_id" {
  value       = module.virtual-network[*].vnet_id
  description = "The id of the newly created Vnet."
}

output "vnet_name" {
  value       = module.virtual-network[*].vnet_name
  description = "The Name of the newly created Vnet."
}

output "vnet_location" {
  value       = module.virtual-network[*].vnet_location
  description = "The location of the newly created Vnet."
}

output "subnet_name" {
  value = module.subnet[*].subnet_name

}
output "vnet_address_space" {
  value = module.virtual-network[*].vnet_address_space

}

output "subnet_address_prefixes" {
  value = module.subnet[*].subnet_address_prefixes

}

output "subnet_id" {
  value = module.subnet.*.subnet_id

}