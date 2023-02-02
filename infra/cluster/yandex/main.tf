terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  cloud {
    organization = "eggshell-organization"

    workspaces {
      name = "eggshell-yandex"
    }
  }
}

provider "yandex" {
}


resource "yandex_kubernetes_cluster" "simple-cluster" {
  network_id = data.yandex_vpc_network.default.id
  master {
    zonal {
      zone      = yandex_vpc_subnet.simple-subnet.zone
      subnet_id = yandex_vpc_subnet.simple-subnet.id
    }
  }
  service_account_id      = yandex_iam_service_account.simple-service-account.id
  node_service_account_id = yandex_iam_service_account.simple-service-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}


resource "yandex_vpc_subnet" "simple-subnet" {
  v4_cidr_blocks = ["10.5.0.0/16"]
  zone           = var.zone
  network_id     = data.yandex_vpc_network.default.id
}

resource "yandex_iam_service_account" "simple-service-account" {
  name        = "simple-service-account"
  description = "<service account description>"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  # Service account to be assigned "editor" role.
  folder_id = data.yandex_resourcemanager_folder.eggshell-folder.id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.simple-service-account.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  # Service account to be assigned "container-registry.images.puller" role.
  folder_id = data.yandex_resourcemanager_folder.eggshell-folder.id
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.simple-service-account.id}"
  ]
}
