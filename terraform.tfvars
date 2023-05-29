/*-------------------- Variable values for Resource Group ---------------------------------------*/

resource_group_name     = "rg-himanshuPoC"
resource_group_location = "Australia East"
rg_tags = {
  Name        = "rg-investcorp",
  Environment = "staging",
  Owner       = "DevOps"
}

tags = {
  env  = "Dev"
  group = "Team-Azure"
  owner = "Devops"
}
/*-------------------- Variable values for Vnet ------------------------------------------------*/

vnet_name                   = "vnet-himanshuPoC"
address_space               = ["10.0.0.0/16"]
create_ddos_protection_plan = false
dns_servers                 = []
# /*--------------------- Variable values for Subnet ----------------------------------------*/

subnet_name              = ["sub-pub-himanshuPoC-1"]
subnet_address_prefixes  = ["10.0.0.0/24"]
subnet_service_endpoints = ["Microsoft.AzureActiveDirectory"]


