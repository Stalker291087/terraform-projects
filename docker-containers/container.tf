# Resource block to create the docker image
resource "random_string" "random-string" {
  length  = 4
  special = false
  upper   = false
  count = 2
}
# Creating docker image
resource "docker_image" "docker-image" {
  name = var.docker-image
}
# Creating docker container
resource "docker_container" "docker-container" {
  count = 2
  name  = join("-", [var.container-name, random_string.random-string[count.index].result])
  image = docker_image.docker-image.name
  ports {
    internal = var.docker-ports["host"]
    #external = var.docker-ports["container"]
  }
}