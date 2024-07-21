variable "docker-image" {
  type        = string
  description = "Docker image to be deployed"
}

variable "container-name" {
  type        = string
  description = "Name of container to be deployed"
}

variable "docker-ports" {
  type        = map(string)
  description = "Docker ports to be mapped"
}