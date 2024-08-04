# Resource block to create random strings to assign the container name
resource "random_string" "random-string" {
  length  = 4
  special = false
  upper   = false
  count   = var.count_in
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
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volume_output[volumes.key]
    }
  }
  provisioner "local-exec" {
    command = "echo ${self.name} - ${self.network_data[0].ip_address}:${join("", [for port in self.ports[*]["external"] : port])} >> containers.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }
}

module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.container_name_in}-${terraform.workspace}-${random_string.random-string[count.index].result}-volume"
}