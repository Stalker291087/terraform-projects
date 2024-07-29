# Creating docker container
resource "docker_container" "docker-container" {
  name  = var.container_name_in
  image = var.container_image_in
  ports {
    internal = var.docker_internal_in
    external = var.docker_external_in
  }
  volumes {
    container_path = var.docker_container_path_in
    volume_name = docker_volume.docker-container-volume.name
  }
}

resource "docker_volume" "docker-container-volume" {
  name = "${var.container_name_in}-volume"
}