#data "azurerm_subnet" "alpha-subnet2-tf" {
#name                 = "alpha-subnet2-tf"
#virtual_network_name = "alpha-vnet-tf"
#resource_group_name  = azurerm_resource_group.alpha-rg-tf.name
#}

#output "subnet_id" {
#value = data.azurerm_subnet.alpha-subnet2-tf.id
#}

# CREATE A NETWORK INTERFACE
resource "azurerm_network_interface" "alpha-nic1" {
  name                = "${var.prefix}-nic1"
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  ip_configuration {
    name      = "testconfiguration1"
    subnet_id = azurerm_subnet.alpha-subnet2-tf.id
    #subnet_id                     = azurerm_subnet.alpha-subnet2-tf.value
    #subnet_id                     = azurerm_subnet.subnet_id-tf.value
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "alpha-nic2" {
  name                = "${var.prefix}-nic2"
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  ip_configuration {
    name      = "testconfiguration2"
    subnet_id = azurerm_subnet.alpha-subnet2-tf.id
    #subnet_id                     = azurerm_subnet.alpha-subnet2-tf.value
    #subnet_id                     = azurerm_subnet.subnet_id-tf.value
    private_ip_address_allocation = "Dynamic"
  }
}

# CREATE VM Using Standard Ubuntu Image
resource "azurerm_virtual_machine" "alpha-vm" {
  name                  = "${var.prefix}-alphavm"
  location              = var.location
  resource_group_name   = var.azurerm_resource_group
  network_interface_ids = [azurerm_network_interface.alpha-nic1.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  #storage_image_reference {
  #   publisher = "Canonical"
    # offer     = "0001-com-ubuntu-server-focal"
      #sku       = "20_04-lts-gen2"
      #version   = "20.04.202306180"
  #}
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}




# CREATE VM Using a Packer Image
data "azurerm_image" "alpha-image" {
  name                = "iris-az-packer-image"
  resource_group_name = "alpha-kumar-rg"
}

resource "azurerm_linux_virtual_machine" "alpha-betavm" {
  name                  = "alpha-betavm"
  resource_group_name   = var.azurerm_resource_group
  location              = var.location
  size                  = "Standard_DS2_v2"
  admin_username        = "ssadcloud"
  network_interface_ids = [azurerm_network_interface.alpha-nic2.id]

  admin_ssh_key {
    username   = "ssadcloud"
    public_key = file("/home/ssadcloud/.ssh/id_rsa.pub")
  }

    #os_profile_linux_config {
    # disable_password_authentication = false
  #}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.alpha-image.id

}
