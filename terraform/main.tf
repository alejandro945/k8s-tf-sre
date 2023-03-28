provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rm" {
  name     = "${var.prefix}-k8s-resources"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "rm" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_kubernetes_cluster" "rm" {
  name                = azurerm_kubernetes_cluster.rm.name
  resource_group_name = azurerm_resource_group.rm.name
}

resource "local_sensitive_file" "kubeconfig" {
  content  = data.azurerm_kubernetes_cluster.rm.kube_config_raw
  filename = "${path.module}/kubeconfig"
}

# terraform output kube_config > kubeconfig
# az aks get-credentials --resource-group rm-k8s-resources --name rm-k8s --file ./kubeconfig

# Configurar kubectl config
# kubectl config get-contexts
# kubectl config use-context rm-k8s
# kubectl apply -f deployment.yaml
