
data "yandex_resourcemanager_folder" "eggshell-folder" {
  name = "eggshell-folder"
}
data "yandex_vpc_network" "default" {
  name = "default"
}

data "yandex_vpc_subnet" "default" {
  name = "default-ru-central1-a"
}
