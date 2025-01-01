# Declare Random Pet Resource
resource "random_pet" "prefix" {
  length    = 2
  prefix    = var.resource_group_name_prefix  # Use variable for prefix
  separator = "-"
}

# Declare Resource Group
resource "azurerm_resource_group" "default" {
  name     = "${random_pet.prefix.id}-rg"  # Combine random pet ID with the prefix
  location = var.resource_group_location   # Use variable for location
}

# Declare AKS Cluster
resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2ms"
  }

  identity {
    type = "SystemAssigned"
  }
}
