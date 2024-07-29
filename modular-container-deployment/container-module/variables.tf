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

variable "docker_container_path_in" {
 description = "Path of the docker container for persistent storage" 
}

variable "docker_host_path_in" {
  description = "Path on the host for persistent storage"
}