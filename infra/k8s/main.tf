terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
}

# ##############################################

provider "helm" {
  # Several Kubernetes authentication methods are possible: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#authentication
  kubernetes {
    config_path = "~/.kube/config"
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

}

resource "helm_release" "k8s-dashboard" {
  name = "k8s-dashboard"

  repository = "https://kubernetes.github.io/dashboard"
  chart      = "kubernetes-dashboard"
  namespace  = "kube-system"
  version    = "6.0.0"
  # create_namespace = true

  # to access http://localhost:8001/api/v1/namespaces/kube-system/services/http:k8s-dashboard-kubernetes-dashboard:http/proxy
  set {
    name  = "enableInsecureLogin"
    value = "true"
  }
  set {
    name  = "enableSkipLogin"
    value = "true"
  }
  set {
    name  = "protocolHttp"
    value = "true"
  }
  set {
    name  = "rbac.clusterReadOnlyRole"
    value = "true"
  }
}


