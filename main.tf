locals {
  common_tags = {
    purpose                  = "terraform_plurasight_deep_dive"
    terraform_state_location = "local"
  }
}

data "http" "ip" {
  url = "https://api.ipify.org/"
  retry {
    attempts     = 5
    max_delay_ms = 1000
    min_delay_ms = 500
  }
}


# data "azurerm_key_vault" "kv-main-generic" {
#   name                = "kv-main-generic"
#   resource_group_name = "rg-fixed-resources"
# }

# data "azurerm_key_vault_secret" "VM_Admin_Generic_Password" {
#   name         = "VM-Generic-Admin-Password"
#   key_vault_id = data.azurerm_key_vault.kv-main-generic.id
# }

resource "random_id" "rg_name" {
  byte_length = 8
}


resource "azurerm_resource_group" "rg_main" {
  location = var.location
  name     = "rg-terra-${random_id.rg_name.dec}"
}


module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  vnet_name           = "terraformVNET"
  resource_group_name = azurerm_resource_group.rg_main.name
  use_for_each        = var.use_for_each
  vnet_location       = var.location
  address_space       = ["10.77.0.0/16"]
  subnet_prefixes     = ["10.77.1.0/24", "10.77.2.0/24", "10.77.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.ssh.id
    subnet2 = azurerm_network_security_group.ssh.id
    subnet3 = azurerm_network_security_group.ssh.id
  }
  tags = local.common_tags

}

resource "azurerm_network_security_group" "ssh" {
  location            = azurerm_resource_group.rg_main.location
  name                = "NSG_ForTerraformVNET"
  resource_group_name = azurerm_resource_group.rg_main.name

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "AllowSSHInboundFromLocalIP"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*" #"${data.http.ip.response_body}/32"
    source_port_range          = "*"
  }
}

module "virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "~> 0.13"

  resource_group_name = azurerm_resource_group.rg_main.name
  os_type             = "linux"
  name                = "VMTerraform"
  sku_size            = "Standard_B1ls"
  location            = var.location
  zone                = null

  managed_identities = {
    system_assigned = true
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interfaces = {
    private = {
      name = "MainNIC_terraformVM"
      ip_configurations = {
        main_ip_config = {
          name                          = "private_ipconfig"
          private_ip_subnet_resource_id = lookup(module.vnet.vnet_subnets_name_id, "subnet1")
          create_public_ip_address = true
          public_ip_address_name = "vm-terraform-publicip1"
        }

      }
    }
  }


  public_ip_configuration_details = {
    "allocation_method" : "Static",
    "ddos_protection_mode" : "VirtualNetworkInherited",
    "idle_timeout_in_minutes" : 30,
    "ip_version" : "IPv4",
    "sku" : "Standard",
    "sku_tier" : "Regional"
  }

  tags = local.common_tags

  admin_username                  = var.vm_adminusername
  admin_password                  = var.vm_adminpsw
  disable_password_authentication = false
}
