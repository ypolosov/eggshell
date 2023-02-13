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


resource "yandex_kubernetes_cluster" "yandex-k8s-cluster" {
  name       = "yandex-k8s-cluster"
  network_id = data.yandex_vpc_network.default.id
  master {
    zonal {
      zone      = data.yandex_vpc_subnet.default.zone
      subnet_id = data.yandex_vpc_subnet.default.id
    }
    public_ip = true
    version   = "1.22"
  }
  service_account_id      = yandex_iam_service_account.simple-service-account.id
  node_service_account_id = yandex_iam_service_account.simple-service-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}

resource "yandex_iam_service_account" "simple-service-account" {
  name        = "simple-service-account"
  description = "There is a service account description"
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

resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = yandex_kubernetes_cluster.yandex-k8s-cluster.id
  name        = "yandex-k8s-cluster-node-group"
  description = "Some description is here"
  version     = "1.22"

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = "standard-v1"

    network_interface {
      nat        = true
      subnet_ids = ["${data.yandex_vpc_subnet.default.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = data.yandex_vpc_subnet.default.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}
