locals {
  project             = var.project_override != "" ? var.project_override : "aks-azure"
  resource_group_name = "${var.stage}-${locals.project}-rg"
  vnet_name           = "${var.stage}-${locals.project}-vnet"
  aks_name            = "${var.stage}-${locals.project}-aks"
  dns_prefix          = var.dns_prefix_override != "" ? var.dns_prefix_override : local.aks_name
  tags = {
    stage   = var.stage
    project = local.project
  }

}