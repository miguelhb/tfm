####################
# Common Variables #
####################
company     = "UPM"
app_name    = "tfm"
environment = "development"
location    = "westeurope"
resource_group = "terraform-tfm"

###########
# Network #
###########
network-vnet-cidr   = "10.128.0.0/16"
network-subnet-cidr = "10.128.1.0/24"
bastion-subnet-cidr = "10.128.2.0/27"


###############
# VM with SQL #
###############
web_vm_size        = "Standard_F2s_v2"
web_admin_username = "group4"
web_admin_password = "Group4"
