resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.aks_config.network_profile.network_plugin != "none" ? 1 : 0
  name                = local.vnet_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.0.0.0/16"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "this" {
  name                = local.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = local.dns_prefix
  kubernetes_version  = var.kubernetes_version
  network_profile = {
    network_plugin = var.aks_config.network_profile.network_policy == "azure" ? "azure" : aks_config.network_profile.network_plugin
    network_policy = var.aks_config.network_profile.network_policy
  }

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = ((var.aks_config.network_profile.network_plugin != "none") || (var.aks_config.network_profile.network_policy == "azure") ?
     azurerm_virtual_network.vnet.id : null)
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}