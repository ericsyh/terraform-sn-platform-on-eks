output "operator_namespace" {
  value = kubernetes_namespace.sns.metadata.0.name
}

output "sn_platform_namespace" {
  value = kubernetes_namespace.snp.metadata.0.name
}