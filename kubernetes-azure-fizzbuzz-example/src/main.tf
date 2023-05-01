locals {
  public_ip_id = data.azurerm_lb.main.frontend_ip_configuration[1].public_ip_address_id
  public_ip = {
    name = element(split("/", local.public_ip_id), index(split("/", local.public_ip_id), "publicIPAddresses") + 1)
    rg   = element(split("/", local.public_ip_id), index(split("/", local.public_ip_id), "resourceGroups") + 1)
  }
  k8s_id = var.kubernetes_cluster.data.infrastructure.ari
  k8s = {
    name   = element(split("/", local.k8s_id), index(split("/", local.k8s_id), "managedClusters") + 1)
    sub_id = element(split("/", local.k8s_id), index(split("/", local.k8s_id), "subscriptions") + 1)
  }
}

module "helm" {
  source             = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm?ref=b4401ac"
  name               = var.md_metadata.name_prefix
  namespace          = var.namespace
  chart              = "${path.module}/chart"
  kubernetes_cluster = var.kubernetes_cluster
  additional_envs    = []
}

data "kubernetes_service_v1" "main" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "md-core-services"
  }
}

data "azurerm_lb" "main" {
  name                = "kubernetes"
  resource_group_name = "mc_${local.k8s.name}_${local.k8s.name}_${var.kubernetes_cluster.specs.azure.region}"
}

data "azurerm_public_ip" "main" {
  name                = local.public_ip.name
  resource_group_name = local.public_ip.rg
}

data "azurerm_kubernetes_cluster_node_pool" "main" {
  name                    = "default"
  kubernetes_cluster_name = local.k8s.name
  resource_group_name     = local.k8s.name
}

resource "azurerm_network_security_group" "main" {
  name                = local.k8s.name
  resource_group_name = local.k8s.name
  location            = var.kubernetes_cluster.specs.azure.region
  tags                = var.md_metadata.default_tags
}

resource "azurerm_network_security_rule" "http" {
  name                        = "AksHttpInbound"
  priority                    = 601
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "Internet"
  destination_port_range      = 80
  destination_address_prefix  = data.azurerm_public_ip.main.ip_address
  resource_group_name         = local.k8s.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "main" {
  network_security_group_id = azurerm_network_security_group.main.id
  subnet_id                 = data.azurerm_kubernetes_cluster_node_pool.main.vnet_subnet_id
}
