resource "azurerm_network_security_group" "alpha-nsg-tf" {
  name                = "alpha-nsg-tf"
  location            = var.location
  resource_group_name = var.azurerm_resource_group
}

resource "azurerm_network_security_rule" "alpha-nsg-rule-80-tf" {
  name                        = "alpha-nsg-rule-80-tf"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "0.0.0.0/0"
  resource_group_name         = var.azurerm_resource_group
  network_security_group_name = azurerm_network_security_group.alpha-nsg-tf.name
}

resource "azurerm_network_security_rule" "alpha-nsg-rule-8080-tf" {
  name                        = "${var.prefix}-nsg-rule-8080-tf"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "8080"
  destination_port_range      = "8080"
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "0.0.0.0/0"
  resource_group_name         = var.azurerm_resource_group
  network_security_group_name = azurerm_network_security_group.alpha-nsg-tf.name
}

resource "azurerm_network_security_rule" "alpha-nsg-rule-22-tf" {
  name                        = "${var.prefix}-nsg-rule-22-tf"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "22"
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "0.0.0.0/0"
  resource_group_name         = var.azurerm_resource_group
  network_security_group_name = azurerm_network_security_group.alpha-nsg-tf.name
}