provider "azurerm" {
   features {}

}

#### Fortigate Firewall's ####

module "fgt1" {
  source                           = "./modules/fgt"
  location                         = var.loc-vnets
  custom_image_resource_group_name = var.resgrp-forti
  resource_group_name              = var.resgrp-forti
  vnetname                         = "hub-1" #VNET name
}


#### VNETS (default created with 3 subnets) ####

module "spoke1-vnet" {                                         # Terraform ref name of module (input)
  source              = "./modules/single-vnet"
  depends_on          = [module.fgt1.azurerm_virtual_network]
  resource_group_name = "rg-spoke1-vnets"                      # Name of the resource group (input)
  address_space-vnets = "10.255.0.0/16"                        # CIDR blokk of the VNET (input)
  location            = "westus"                               # Location, eastus,westus,northeurope..etc (input)
  name-vnets          = "spoke1"                               # Name of the VNET (input)
  hub-vnet            = module.fgt1.hub-vnet-111
  hub-vnet-name       = module.fgt1.hub-vnet-222
  hub-vnet-rg         = module.fgt1.hub-vnet-rg
  fgt-priv-ip         = module.fgt1.fgt-priv-ip
 
}
module "spoke2-vnet" {
  source              = "./modules/single-vnet"
  depends_on          = [module.fgt1.azurerm_virtual_network]
  resource_group_name = "rg-spoke2-vnets"
  address_space-vnets = "10.254.0.0/16"
  location            = "westus"
  name-vnets          = "spoke2"
  hub-vnet            = module.fgt1.hub-vnet-111
  hub-vnet-name       = module.fgt1.hub-vnet-222
  hub-vnet-rg         = module.fgt1.hub-vnet-rg
  fgt-priv-ip         = module.fgt1.fgt-priv-ip
}
module "spoke3-vnet" {
  source              = "./modules/single-vnet"
  depends_on          = [module.fgt1.azurerm_virtual_network]
  resource_group_name = "rg-spoke3-vnets"
  address_space-vnets = "10.253.0.0/16"
  location            = "westus"
  name-vnets          = "spoke3"
  hub-vnet            = module.fgt1.hub-vnet-111
  hub-vnet-name       = module.fgt1.hub-vnet-222
  hub-vnet-rg         = module.fgt1.hub-vnet-rg
  fgt-priv-ip         = module.fgt1.fgt-priv-ip
}