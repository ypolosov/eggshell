
data "yandex_compute_image" "last_ubuntu" {
  family = "ubuntu-2204-lts" # ОС (Ubuntu, 22.04 LTS)
}

data "yandex_vpc_subnet" "default_a" {
  name = "default-ru-central1-a" # одна из дефолтных подсетей
}
