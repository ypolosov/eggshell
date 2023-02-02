
data "yandex_resourcemanager_folder" "eggshell-folder" {
  name = "eggshell-folder"
}
data "yandex_vpc_network" "default" {
  name = "default"
}
