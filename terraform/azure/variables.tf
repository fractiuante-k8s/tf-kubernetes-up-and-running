variable "stage" {
  default = "dev"
}

variable "location" {
  default = "West Europe"
}

variable "dns_prefix_override" {
  default = ""
  type    = string
}

variable "project_override" {
  default = ""
  type    = string
}

variable "aks_config" {
  type = object({
    kubernetes_version = optional(string, "1.26.0")
    network_profile = object({
      network_plugin = optional(string, "none") # One of ["azure" | "kubenet" | "none"]
      network_policy = string                   # One of [null | "calico" | "azure"]
    })
  })
}   