# Resource block to create random strings to assign the container name
resource "random_string" "random-string" {
  length  = 4
  special = false
  upper   = false
  count   = local.container_count
}
# Module block to create the docker image
module "docker-image" {
  source          = "./container-image-module"
  docker_image_in = var.docker-image[terraform.workspace]
}
# Creating docker container
module "docker-container" {
  source                   = "./container-module"
  count                    = local.container_count
  container_name_in        = join("-", [var.container-name, random_string.random-string[count.index].result, terraform.workspace])
  container_image_in       = module.docker-image.docker-image-out
  docker_internal_in       = var.internal-ports
  docker_external_in       = var.external-ports[terraform.workspace][count.index]
  docker_container_path_in = var.container-data-path
}
