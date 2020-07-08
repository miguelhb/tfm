######################
## Network - Output ##
######################


output "network_vnet_id" {
  value = azurerm_virtual_network.network-vnet.id
}

output "network_subnet_id" {
  value = azurerm_subnet.network-subnet.id
}
