# Resource block to create the docker image
resource "docker_image" "docker-image" {
  name = var.docker-image
}

resource "docker_container" "docker-container" {
  name     = var.container-name
  image    = docker_image.docker-image.name
  ports {
    internal = var.docker-ports["host"]
    external = var.docker-ports["container"]
  }
}