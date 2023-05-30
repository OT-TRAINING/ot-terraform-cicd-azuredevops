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