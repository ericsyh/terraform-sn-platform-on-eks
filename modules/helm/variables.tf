variable "host" {
  description = "AWS EKS Cluster host"
}

variable "cluster_ca_certificate" {
  description = "AWS EKS Cluster cluster_ca_certificate"
}

variable "token" {
  description = "AWS EKS Cluster token"
}

variable "operator_namespace" {
  description = "Azure Kubernetes namespace for operators"
}

variable "sn_platform_namespace" {
  description = "Azure Kubernetes namespace for sn-platform"
}