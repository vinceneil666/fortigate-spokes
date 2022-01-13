output "ResourceGroup" {
  value = azurerm_resource_group.myterraformgroup.name
}

output "FGTPublicIP" {
  value = azurerm_public_ip.FGTPublicIp.ip_address

}

output "Username" {
  value = var.adminusername
}

output "Password" {
  value = var.adminpassword
}
output "hub-vnet-111" {
    value = azurerm_virtual_network.fgtvnetwork.id
}
output "hub-vnet-222" {
    value = azurerm_virtual_network.fgtvnetwork.name
}
output "hub-vnet-rg" {
    value = azurerm_resource_group.myterraformgroup.name
}
output "fgt-priv-ip" {
    value = azurerm_network_interface.fgtport2.ip_configuration[0].private_ip_address
}