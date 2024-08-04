# Module block to create the docker image
module "container-image" {
  source          = "./container-image-module"
  for_each        = local.deployment
  docker_image_in = each.value.image
}

# Creating docker container
module "docker-container" {
  source                   = "./container-module"
  for_each                 = local.deployment
  count_in = each.value.container_count
  container_name_in        = each.key
  container_image_in       = module.container-image[each.key].docker-image-out
  docker_internal_in       = each.value.int_port
  docker_external_in       = each.value.ext_port
  docker_container_path_in = each.value.container_path
}
