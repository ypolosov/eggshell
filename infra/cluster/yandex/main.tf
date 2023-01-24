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

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores         = 2 # vCPU
    memory        = 1 # RAM
  }

  boot_disk {
    initialize_params {
      image_id = "fd89n8278rhueakslujo" # ОС (Ubuntu, 22.04 LTS)
    }
  }

  network_interface {
    subnet_id = "e9bc77o2lksui2mht6o7" # одна из дефолтных подсетей
    nat       = true                   # автоматически установить динамический ip
  }
}
