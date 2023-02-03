terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.16"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
}

# ##############################################

provider "kind" {}

resource "kind_cluster" "argocd-cluster" {
  name = "argocd-cluster"
}

provider "helm" {
  # Several Kubernetes authentication methods are possible: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#authentication
  kubernetes {
    host                   = kind_cluster.argocd-cluster.endpoint
    cluster_ca_certificate = kind_cluster.argocd-cluster.cluster_ca_certificate
    client_key             = kind_cluster.argocd-cluster.client_key
    client_certificate     = kind_cluster.argocd-cluster.client_certificate
  }
}


# ############################################


resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.19.14"
  create_namespace = true

  values = [
    # file("argocd/application.yaml")
  ]
}
