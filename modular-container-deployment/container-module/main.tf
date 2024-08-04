# Resource block to create random strings to assign the container name
resource "random_string" "random-string" {
  length   = 4
  special  = false
  upper    = false
  count = var.count_in
}

# Creating docker container
resource "docker_container" "docker-container" {
  count = var.count_in
  name  = join("-", [var.container_name_in, random_string.random-string[count.index].result, terraform.workspace])
  image = var.container_image_in
  ports {
    internal = var.docker_internal_in
    external = var.docker_external_in[count.index]
  }
  volumes {
    container_path = var.docker_container_path_in
    volume_name = docker_volume.docker-container-volume[count.index].name
  }
}

resource "docker_volume" "docker-container-volume" {
  count = var.count_in
  name = "${var.container_name_in}-${random_string.random-string[count.index].result}-volume"
  lifecycle {
    prevent_destroy = false
  }
}