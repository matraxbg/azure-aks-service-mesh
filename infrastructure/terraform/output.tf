output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

output "resource_group_name" {
  value = azurerm_resource_group.aks.name
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}