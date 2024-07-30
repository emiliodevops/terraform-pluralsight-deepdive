terraform {
  required_version = "~>1.9.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }


}

provider "azurerm" {
  features {}
}
