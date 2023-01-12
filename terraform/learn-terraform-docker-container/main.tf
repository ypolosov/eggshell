terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image    = docker_image.nginx.latest
  name     = var.container_name
  hostname = "learn-terraform-docker"
  ports {
    internal = 80
    external = 8080
  }
}
