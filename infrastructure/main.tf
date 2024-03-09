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
    vm_size    = var.enable_istio_addon ? "Standard_B2ms" : "Standard_B2s"
  }

  dynamic "service_mesh_profile" {
    for_each = var.enable_istio_addon ? [1] : []

    content {
      mode                             = "Istio"
      internal_ingress_gateway_enabled = true
      external_ingress_gateway_enabled = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}