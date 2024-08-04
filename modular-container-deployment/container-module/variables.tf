variable "container_name_in" {
  description = "Name of the container to be created"
}

variable "container_image_in" {
  description = "Name of the container image to be use"
}

variable "docker_internal_in" {
  description = "Internal port of the docker container"
}

variable "docker_external_in" {
  description = "External port of the docker container"
}

variable "count_in" {
  description = "Number of containers to be deployed"
}

variable "volumes_in" {
  description = "Container volumes to be created"
}