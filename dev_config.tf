provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dev_resources" {
  name     = "dev-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "devnet_0" {
  name                = "dev-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.dev_resources.location
  resource_group_name = azurerm_resource_group.dev_resources.name
}

resource "azurerm_public_ip" "dev_publicip" {
  name                = "dev-publicip"
  location            = azurerm_resource_group.dev_resources.location
  resource_group_name = azurerm_resource_group.dev_resources.name
  allocation_method   = "Static"  # You can choose "Dynamic" if needed
}

resource "azurerm_network_security_group" "dev_sg" {
  name                = "DevSecurityGroup1"
  location            = azurerm_resource_group.dev_resources.location
  resource_group_name = azurerm_resource_group.dev_resources.name

  security_rule {
    name                       = "devenv-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_ranges    = ["22", "5557"]
    source_address_prefix      = "*"
    destination_address_prefixes = ["10.0.0.0/24"] 
  }
}

resource "azurerm_subnet" "nic_subnet" {
  name                 = "devnic-subnet"
  resource_group_name  = azurerm_resource_group.dev_resources.name
  virtual_network_name = azurerm_virtual_network.devnet_0.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "devNIC" {
  name                = "dev-nic"
  location            = azurerm_resource_group.dev_resources.location
  resource_group_name = azurerm_resource_group.dev_resources.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  azurerm_subnet.nic_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  azurerm_public_ip.dev_publicip.id
  }
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "devapp-subnet"
  resource_group_name  = azurerm_resource_group.dev_resources.name
  virtual_network_name = azurerm_virtual_network.devnet_0.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "data_subnet" {
  name                 = "devdb-subnet"
  resource_group_name  = azurerm_resource_group.dev_resources.name
  virtual_network_name = azurerm_virtual_network.devnet_0.name
  address_prefixes     = ["10.0.3.0/24"]
}

#resource "tls_private_key" "devserver_ssh" {
  #algorithm = "RSA"
  #rsa_bits  = 4096
#}

resource "azurerm_linux_virtual_machine" "devapp_vm" {
  name                            = "devapp-vm"
  resource_group_name             = azurerm_resource_group.dev_resources.name
  location                        = azurerm_resource_group.dev_resources.location
  size                            = "Standard_DS1_v2"
  os_disk {
        caching                   = "ReadWrite"
    storage_account_type          = "Standard_LRS"
  }
  admin_username                  = "adminuser"
  network_interface_ids           = [azurerm_network_interface.devNIC.id]
  admin_ssh_key {
    username                      = "adminuser"
    public_key                    = var.admin_ssh
    #public_key                    = tls_private_key.devserver_ssh.public_key_openssh
    
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_mysql_flexible_server" "dev_db" {
  name                         = "dev-flexible-server"
  location                     = azurerm_resource_group.dev_resources.location
  resource_group_name          = azurerm_resource_group.dev_resources.name
  administrator_login          = var.admin_username
  administrator_password       = var.admin_password
  sku_name                     = "GP_Standard_D2ds_v4"
  #ssl_enforcement_enabled     = true
  #version                     = "8.0"
}

