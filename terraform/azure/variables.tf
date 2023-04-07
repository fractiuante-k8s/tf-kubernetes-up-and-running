variable "stage" {
  default = "dev"
}

variable "location" {
  default = "West Europe"
}

variable "kubernetes_version" {
  default = "1.26.0"
}

variable "dns_prefix_override" {
  default = ""
  type    = string
}

variable "project_override" {
  default = ""
  type    = string
}

variable "aks_settings" {
  type = object({
    vnet_integration = optional(bool, false)
  })
}   