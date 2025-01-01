# Output the Resource Group Name
output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

# Output the AKS Cluster Name
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}
