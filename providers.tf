terraform {
  required_version = ">=0.12"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  alias = "LANGE_4"
  features {}
  subscription_id = var.lange4_sub_id

}

provider "azurerm" {
  alias = "LANGE_3"
  features {}
  subscription_id = var.lange3_sub_id

}