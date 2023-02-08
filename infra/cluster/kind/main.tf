terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.16"
    }
  }
}

# ##############################################

provider "kind" {
}


# ############################################

resource "kind_cluster" "eggshell-cluster" {
  name            = "eggshell-cluster"
  kubeconfig_path = pathexpand("~/.kube/config")

}

