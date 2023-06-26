
resource "azurerm_virtual_network" "alpha-vnet-tf" {
  name                = "${var.prefix}-vnet-tf"
  resource_group_name = var.azurerm_resource_group
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  #subnet {
    #name           = "alpha-subnet1-tf"
    #address_prefix = "10.0.1.0/24"
  #}

  #subnet {
    #name           = "alpha-subnet2-tf"
    #address_prefix = "10.0.2.0/24"
    #security_group = azurerm_network_security_group.alpha-nsg-tf.id
  #}

  tags = {
    environment = "Production"
  }
}

# Resource for Subnet1 Creation
resource "azurerm_subnet" "alpha-subnet1-tf" {
  name                 = "alpha-subnet1-tf"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.alpha-vnet-tf.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Resource for Subnet2 Creation
resource "azurerm_subnet" "alpha-subnet2-tf" {
  name                 = "alpha-subnet2-tf"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.alpha-vnet-tf.name
  address_prefixes     = ["10.0.2.0/24"]
}

  
