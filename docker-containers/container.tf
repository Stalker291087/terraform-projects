# Resource block to create the docker image
resource "random_string" "random-string" {
  length  = 4
  special = false
  upper   = false
  count   = local.container_count
}
# Creating docker image
resource "docker_image" "docker-image" {
  name = var.docker-image[terraform.workspace]
}
# Creating docker container
resource "docker_container" "docker-container" {
  count = local.container_count
  name  = join("-", [var.container-name, terraform.workspace, random_string.random-string[count.index].result])
  image = docker_image.docker-image.name
  ports {
    internal = var.internal-ports
    external = var.external-ports[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    host_path      = "${var.host-data-path}${var.data-directory-name}/"
  }
}

resource "null_resource" "docker-vol" {
  provisioner "local-exec" {
    command = "mkdir ${var.host-data-path}${var.data-directory-name}/ || true && sudo chown 1000:1000  ${var.host-data-path}${var.data-directory-name}/"
  }
}
# resource block to be use if a container import is neccesary
# resource "docker_container" "docker-container-import" {
#   name  = "node-red-l52o"
#   image = docker_image.docker-image.name
# }