resource_group_name         = ["rg-otms-qa-southbrazil"]
resource_group_location     = "Brazil South"
lock_level_value            = ""
address_space               = [["10.0.0.0/16"]]
vnet_name                   = ["vnet-otms-qa-southbrazil-001"]
vnet_location               = ["Brazil South"]
dns_servers                 = null
create_ddos_protection_plan = [false]
subnet_name                 = [["subnet-otms-qa-southbrazil-001", "subnet-fontendgw-otms-qa-southbrazil-001"]]
subnet_address_prefixes     = [["10.0.0.0/24", "10.0.1.0/24"],]
service_endpoints           = null

tags = {
  env  = "qa"
  group = "Team_Azure"
  owner = "Devops"
}


vm_name   = ["vm-es-otms-qa-southbrazil-001", "vm-mysql-otms-qa-southbrazil-001"]
vm_size   = "Standard_B2s"
#---------------nsg------------
azurem_security_group_name = ["nsg-es-otms-qa-southbrazil-001", "vm-mysql-qa-southbrazil-001"]
azurem_custom_nsg_rules = [
  {
    name                       = ["allow1", "allow2"]
    priority                   = ["110", "120"]
    direction                  = ["Inbound", "Inbound"]
    access                     = ["Allow", "Allow"]
    protocol                   = ["Tcp", "Tcp"]
    source_port_range          = ["*", "*"]
    destination_port_range     = ["22", "22"]
    source_address_prefix      = ["10.0.0.0/16", "10.0.0.0/16"]  # Update with your trusted source IP ranges
    destination_address_prefix = ["*", "*"]
  },
  {
    name                       = ["allow11", "allow12"]
    priority                   = ["210", "220"]
    direction                  = ["Inbound", "Inbound"]
    access                     = ["Allow", "Allow"]
    protocol                   = ["Tcp", "Tcp"]
    source_port_range          = ["*", "*"]
    destination_port_range     = ["9200", "3306"]
    source_address_prefix      = ["10.0.0.0/16", "10.0.0.0/16"]  # Update with your trusted source IP ranges
    destination_address_prefix = ["*", "*"]
  },
  {
    name                       = ["allow31", "allow32"]
    priority                   = ["300", "310"]
    direction                  = ["Inbound", "Inbound"]
    access                     = ["Allow", "Allow"]
    protocol                   = ["Tcp", "Tcp"]
    source_port_range          = ["*", "*"]
    destination_port_range     = ["80", "80"]
    source_address_prefix      = ["10.0.0.0/16", "10.0.0.0/16"]  # Update with your trusted source IP ranges
    destination_address_prefix = ["*", "*"]
  },
  {
    name                       = ["allow41", "allow42"]
    priority                   = ["410", "420"]
    direction                  = ["Inbound", "Inbound"]
    access                     = ["Allow", "Allow"]
    protocol                   = ["Tcp", "Tcp"]
    source_port_range          = ["*", "*"]
    destination_port_range     = ["3100", "3100"]
    source_address_prefix      = ["*", "*"]  # Update with your trusted source IP ranges
    destination_address_prefix = ["*", "*"]
  },
]



vm_storage_image_reference_1 = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
}
