provider "azurerm" {
  version         = ">= 2.0"
  features {}
}  
###########################################
## Azure Linux VM with Web Module - Main ##
###########################################


# Generate random password
resource "random_password" "web-vm-password" {
  length           = 16
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  number           = true
  special          = true
  override_special = "!@#$%&"
}

# Generate a random vm name
resource "random_string" "web-vm-name" {
  length  = 8
  upper   = false
  number  = false
  lower   = true
  special = false
}


# Create Security Group to access web
resource "azurerm_network_security_group" "app-vm-nsg" {
  name                = "terraform-vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group
  

  security_rule {
    name                       = "AllowSwarm1"
    description                = "Allow swarm client comm"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2376"
    source_address_prefix      = var.network-subnet-cidr
    destination_address_prefix = var.network-subnet-cidr
  }

  security_rule {
    name                       = "AllowSwarm2"
    description                = "Allow swarm nodes comm"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2377"
    source_address_prefix      = var.network-subnet-cidr
    destination_address_prefix = var.network-subnet-cidr
  }

  security_rule {
    name                       = "AllowSwarm3"
    description                = "Allow swarm container network discovery"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7946"
    source_address_prefix      = var.network-subnet-cidr
    destination_address_prefix = var.network-subnet-cidr
  }

  security_rule {
    name                       = "AllowSwarm4"
    description                = "Allow swarm container network discovery"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "7946"
    source_address_prefix      = var.network-subnet-cidr
    destination_address_prefix = var.network-subnet-cidr
  }

  security_rule {
    name                       = "AllowSwarm5"
    description                = "Allow swarm overlay traffic"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4789"
    source_address_prefix      = var.network-subnet-cidr
    destination_address_prefix = var.network-subnet-cidr
  }

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.network-subnet-cidr
  }

  security_rule {
    name                       = "DenyVnet"
    description                = "Deny Vnet"
    priority                   = 4069
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    environment = var.environment
  }
}

# Associate the web NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "web-vm-nsg-association" {
#  depends_on=[azurerm_resource_group.network-rg]

  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.app-vm-nsg.id
}

# Get a Static Public IP
resource "azurerm_public_ip" "web-vm-ip" {
  name                = "terraform-vm-ip"
  location            =  var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
  
  tags = { 
    environment = var.environment
  }
}

# Create Network Card for VM1
resource "azurerm_network_interface" "app1-private-nic" {

  name                = "terraform-vm1-nic"
  location            = var.location
  resource_group_name = var.resource_group  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Create Network Card for VM2
resource "azurerm_network_interface" "app2-private-nic" {

  name                = "terraform-vm2-nic"
  location            = var.location
  resource_group_name = var.resource_group  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Create Network Card for VM3
resource "azurerm_network_interface" "app3-private-nic" {

  name                = "terraform-vm3-nic"
  location            = var.location
  resource_group_name = var.resource_group  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Create Network Card for VM4
resource "azurerm_network_interface" "app4-private-nic" {

  name                = "terraform-vm4-nic"
  location            = var.location
  resource_group_name = var.resource_group  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Create Network Card for VM5
resource "azurerm_network_interface" "app5-private-nic" {

  name                = "terraform-vm5-nic"
  location            = var.location
  resource_group_name = var.resource_group  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}

# Create Network Card for VM6
resource "azurerm_network_interface" "app6-private-nic" {

  name                = "terraform-vm6-nic"
  location            = var.location
  resource_group_name = var.resource_group  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web-vm-ip.id
  }

  tags = { 
    environment = var.environment
  }
}


# Create Linux VM with web server
resource "azurerm_virtual_machine" "vm1" {
  depends_on=[azurerm_network_interface.app1-private-nic]

  location              = var.location
  resource_group_name = var.resource_group
  name                  = "terraform-vm-1"
  network_interface_ids = [azurerm_network_interface.app1-private-nic.id]
  vm_size               = var.web_vm_size
  license_type          = var.web_license_type
  zones                  = ["2"]


  delete_os_disk_on_termination    = var.web_delete_os_disk_on_termination
  delete_data_disks_on_termination = var.web_delete_data_disks_on_termination

  storage_image_reference {
    id        = lookup(var.web_vm_image, "id", null)
    offer     = lookup(var.web_vm_image, "offer", null)
    publisher = lookup(var.web_vm_image, "publisher", null)
    sku       = lookup(var.web_vm_image, "sku", null)
    version   = lookup(var.web_vm_image, "version", null)
  }

  storage_os_disk {
    name              = "terraform-vm-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terraform-vm-1"
    admin_username = var.web_admin_username
    admin_password = var.web_admin_password
  #  custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with web server
resource "azurerm_virtual_machine" "vm2" {
  depends_on=[azurerm_network_interface.app2-private-nic]

  location              = var.location
  resource_group_name = var.resource_group
  name                  = "terraform-vm-2"
  network_interface_ids = [azurerm_network_interface.app2-private-nic.id]
  vm_size               = var.web_vm_size
  license_type          = var.web_license_type
  zones                  = ["1"]


  delete_os_disk_on_termination    = var.web_delete_os_disk_on_termination
  delete_data_disks_on_termination = var.web_delete_data_disks_on_termination

  storage_image_reference {
    id        = lookup(var.web_vm_image, "id", null)
    offer     = lookup(var.web_vm_image, "offer", null)
    publisher = lookup(var.web_vm_image, "publisher", null)
    sku       = lookup(var.web_vm_image, "sku", null)
    version   = lookup(var.web_vm_image, "version", null)
  }

  storage_os_disk {
    name              = "terraform-vm-disk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terraform-vm-2"
    admin_username = var.web_admin_username
    admin_password = var.web_admin_password
  #  custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with web server
resource "azurerm_virtual_machine" "vm3" {
  depends_on=[azurerm_network_interface.app3-private-nic]

  location              = var.location
  resource_group_name = var.resource_group
  name                  = "terraform-vm-3"
  network_interface_ids = [azurerm_network_interface.app3-private-nic.id]
  vm_size               = var.web_vm_size
  license_type          = var.web_license_type
  zones                  = ["3"]


  delete_os_disk_on_termination    = var.web_delete_os_disk_on_termination
  delete_data_disks_on_termination = var.web_delete_data_disks_on_termination

  storage_image_reference {
    id        = lookup(var.web_vm_image, "id", null)
    offer     = lookup(var.web_vm_image, "offer", null)
    publisher = lookup(var.web_vm_image, "publisher", null)
    sku       = lookup(var.web_vm_image, "sku", null)
    version   = lookup(var.web_vm_image, "version", null)
  }

  storage_os_disk {
    name              = "terraform-vm-disk3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terraform-vm-3"
    admin_username = var.web_admin_username
    admin_password = var.web_admin_password
  #  custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with web server
resource "azurerm_virtual_machine" "vm4" {
  depends_on=[azurerm_network_interface.app4-private-nic]

  location              = var.location
  resource_group_name = var.resource_group
  name                  = "terraform-vm-4"
  network_interface_ids = [azurerm_network_interface.app4-private-nic.id]
  vm_size               = var.web_vm_size
  license_type          = var.web_license_type
  zones                  = ["1"]


  delete_os_disk_on_termination    = var.web_delete_os_disk_on_termination
  delete_data_disks_on_termination = var.web_delete_data_disks_on_termination

  storage_image_reference {
    id        = lookup(var.web_vm_image, "id", null)
    offer     = lookup(var.web_vm_image, "offer", null)
    publisher = lookup(var.web_vm_image, "publisher", null)
    sku       = lookup(var.web_vm_image, "sku", null)
    version   = lookup(var.web_vm_image, "version", null)
  }

  storage_os_disk {
    name              = "terraform-vm-disk4"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terraform-vm-4"
    admin_username = var.web_admin_username
    admin_password = var.web_admin_password
  #  custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with web server
resource "azurerm_virtual_machine" "vm5" {
  depends_on=[azurerm_network_interface.app5-private-nic]

  location              = var.location
  resource_group_name = var.resource_group
  name                  = "terraform-vm-5"
  network_interface_ids = [azurerm_network_interface.app5-private-nic.id]
  vm_size               = var.web_vm_size
  license_type          = var.web_license_type
  zones                  = ["2"]


  delete_os_disk_on_termination    = var.web_delete_os_disk_on_termination
  delete_data_disks_on_termination = var.web_delete_data_disks_on_termination

  storage_image_reference {
    id        = lookup(var.web_vm_image, "id", null)
    offer     = lookup(var.web_vm_image, "offer", null)
    publisher = lookup(var.web_vm_image, "publisher", null)
    sku       = lookup(var.web_vm_image, "sku", null)
    version   = lookup(var.web_vm_image, "version", null)
  }

  storage_os_disk {
    name              = "terraform-vm-disk5"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terraform-vm-5"
    admin_username = var.web_admin_username
    admin_password = var.web_admin_password
  #  custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}

# Create Linux VM with web server
resource "azurerm_virtual_machine" "vm6" {
  depends_on=[azurerm_network_interface.app6-private-nic]

  location              = var.location
  resource_group_name = var.resource_group
  name                  = "terraform-vm-6"
  network_interface_ids = [azurerm_network_interface.app2-private-nic.id]
  vm_size               = var.web_vm_size
  license_type          = var.web_license_type
  zones                  = ["3"]


  delete_os_disk_on_termination    = var.web_delete_os_disk_on_termination
  delete_data_disks_on_termination = var.web_delete_data_disks_on_termination

  storage_image_reference {
    id        = lookup(var.web_vm_image, "id", null)
    offer     = lookup(var.web_vm_image, "offer", null)
    publisher = lookup(var.web_vm_image, "publisher", null)
    sku       = lookup(var.web_vm_image, "sku", null)
    version   = lookup(var.web_vm_image, "version", null)
  }

  storage_os_disk {
    name              = "terraform-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "terraform-vm-6"
    admin_username = var.web_admin_username
    admin_password = var.web_admin_password
  #  custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.environment
  }
}