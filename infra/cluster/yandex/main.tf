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
  zone = var.zone
}

resource "yandex_compute_instance" "default" {
  name        = "test-instance"
  platform_id = "standard-v1" # тип процессора (Intel Broadwell)

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores         = 2 # vCPU
    memory        = 1 # RAM
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.last_ubuntu.id # ОС (Ubuntu, 22.04 LTS)
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default_a.subnet_id # одна из дефолтных подсетей
    nat       = true                                       # автоматически установить динамический ip
  }
}
