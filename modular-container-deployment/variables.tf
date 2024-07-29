variable "docker-image" {
  type        = map(string)
  description = "Docker image to be deployed"
}

variable "container-name" {
  type        = string
  description = "Name of container to be deployed"
}

variable "external-ports" {
  type        = map(list(number))
  description = "Host ports to be mapped"

  validation {
    condition     = max(var.external-ports["dev"]...) <= 65532 && min(var.external-ports["dev"]...) >= 1980
    error_message = "Internal port needs to be set to 1880 and external port betweeen '65535 and 0'"
  }

  validation {
    condition     = max(var.external-ports["prod"]...) < 1980 && min(var.external-ports["prod"]...) >= 1880
    error_message = "Internal port needs to be set to 1880 and external port betweeen '65535 and 0'"
  }
}

locals {
  container_count = length(var.external-ports[terraform.workspace])
}

variable "internal-ports" {
  type        = number
  description = "Docker container internal port"

  validation {
    condition     = var.internal-ports == 1880
    error_message = "Internal port needs to be set to 1880 for nodered containers"
  }
}

variable "container-data-path" {
  type        = string
  description = "Docker path to store data in the container"
}