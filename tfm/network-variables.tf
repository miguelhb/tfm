##############################
## Core Network - Variables ##
##############################

variable "network-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}

variable "network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}

variable "bastion-subnet-cidr" {
  type        = string
  description = "The CIDR for the bastion subnet"
}

# azure resource_group
variable "resource_group" {
  type = string
  description = "Azure resource group where resources will be created"
}