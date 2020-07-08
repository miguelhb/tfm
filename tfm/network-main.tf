####################
## Network - Main ##
####################

#Import a Resource Group
data "azurerm_resource_group" "tfm-resource-group" {
  name = var.resource_group
}

# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
  name                = "terraform-tfm-vnet"
  address_space       = [var.network-vnet-cidr]
  resource_group_name = var.resource_group
  location            = var.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}

# Create a subnet for Network
resource "azurerm_subnet" "network-subnet" {
  name                 = "terraform-tfm-subnet"
  address_prefixes       = [var.network-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name = var.resource_group
}

# Create a subnet for Network Bastion 
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  address_prefixes       = [var.bastion-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name = var.resource_group
}

resource "azurerm_public_ip" "bastion-ip" {
  name                = "bastion-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion-host" {
  name                = "bastion-host"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-ip.id
  }
}