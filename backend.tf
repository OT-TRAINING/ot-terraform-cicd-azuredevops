terraform {
  backend "azurerm" {
    resource_group_name  = "terraformInfo"
    storage_account_name = "otstorage98"
    container_name       = "terraform-state-container"
    key                  = "env/uat/network.tfstate"
  }
}

