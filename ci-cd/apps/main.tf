terraform {
  required_providers {


    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.17.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

  }
}

# ##############################################

provider "kubernetes" {
  config_path = "~/.kube/config"
}


provider "helm" {
  # Several Kubernetes authentication methods are possible: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#authentication
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
}



# ############################################


# resource "helm_release" "apps" {
#   name      = "apps"
#   chart     = "./helm"
#   namespace = "argocd"

# }
resource "helm_release" "apps-blue-green" {
  name      = "apps-blue-green"
  chart     = "./helm-blue-green"
  namespace = "argocd"

}


