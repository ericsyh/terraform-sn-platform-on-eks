provider "helm" {
  kubernetes {
    host                   = var.host
    cluster_ca_certificate = var.cluster_ca_certificate
    token = var.token
  }
}

resource "helm_release" "pulsar_operator" {
  name       = "pulsar-operator"
  repository = "https://charts.streamnative.io"
  chart      = "pulsar-operator"
  namespace = var.operator_namespace
  timeout = 600
}

resource "helm_release" "vault_operator" {
  name       = "vault-operator"
  repository = "https://kubernetes-charts.banzaicloud.com"
  chart      = "vault-operator"
  namespace = var.operator_namespace
  timeout = 600
}

resource "helm_release" "sn-platform" {
  name = "sn-platform"
  repository = "https://charts.streamnative.io"
  chart = "sn-platform"
  namespace = var.sn_platform_namespace
  depends_on = [
    helm_release.vault_operator,
    helm_release.pulsar_operator
  ]

  values =[
    "${file("snp.yaml")}"
  ]
  timeout = 1500
}