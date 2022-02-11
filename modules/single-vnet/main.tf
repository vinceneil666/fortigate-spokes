resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
locals {
   subnet_list = {
  "Axl"    = 1
  "Slash"  = 2
  "Duff"   = 3
# "Adler"  = 4 # Remove to add in more subnets
# "Izzy"   = 5 # Remove to add in more subnets
# "Dizzy"  = 6 # Remove to add in more subnets
  }
}
####### VNET #######
resource "azurerm_virtual_network" "generic-vnet" {
    name                = var.name-vnets
    address_space       = [var.address_space-vnets]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = {
           "created by" = "terraform"
           "usefull"    = "hardly"
    }
}
####### SUBNET #######
resource "azurerm_subnet" "subnets" {
  for_each             = local.subnet_list
  name                 = "${each.key}-subnet" 
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.generic-vnet.name
  address_prefixes     = [cidrsubnet(var.address_space-vnets, 8, each.value)]
}
####### SPOKE PEERING #######
resource "azurerm_virtual_network_peering" "example-1" {
  name                      = azurerm_virtual_network.generic-vnet.name
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.generic-vnet.name
  remote_virtual_network_id = var.hub-vnet
  allow_forwarded_traffic   = true  # for subnet segmentation using hub virt app fw
}
####### HUB PEERING #######
resource "azurerm_virtual_network_peering" "example-2" {
  name                      = azurerm_virtual_network.generic-vnet.name
  resource_group_name       = var.hub-vnet-rg
  virtual_network_name      = var.hub-vnet-name
  remote_virtual_network_id = azurerm_virtual_network.generic-vnet.id
  allow_gateway_transit     = true
}

####### ROUTING SPOKES #######
resource "azurerm_route_table" "spokes" {
  name                          = "${azurerm_virtual_network.generic-vnet.name}-rt"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                   = "default-route" # Send internet traffic to hub fw
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.fgt-priv-ip
  }
  route {
    name                   = "vnet-route" # Send intra vnet traffic to hub fw
    address_prefix         = var.address_space-vnets
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.fgt-priv-ip
  }

  tags = {
    "created by" = "terraform"
    "usefull"    = "hardly"
  }
}
resource "azurerm_subnet_route_table_association" "associates" {
  for_each       = local.subnet_list
  subnet_id      = azurerm_subnet.subnets[each.key].id
  route_table_id = azurerm_route_table.spokes.id
}
