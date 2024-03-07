resource "azurerm_resource_group" "aks" {
  name = "aks"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "aks"
  location                  = azurerm_resource_group.aks.location
  resource_group_name       = azurerm_resource_group.aks.name
  dns_prefix                = var.dns_prefix
  sku_tier                  = "Free"
  kubernetes_version        = "1.27.9"
  automatic_channel_upgrade = "patch"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}