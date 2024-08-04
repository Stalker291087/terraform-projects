variable "docker-image" {
  type        = map(map(string))
  description = "Docker image to be deployed"
}

variable "external-ports" {
  type        = map(map(list(number)))
  description = "Host ports to be mapped"

  # validation {
  #   condition     = max(var.external-ports["dev"]...) <= 65532 && min(var.external-ports["dev"]...) >= 1980
  #   error_message = "Internal port needs to be set to 1880 and external port betweeen '65535 and 0'"
  # }

  # validation {
  #   condition     = max(var.external-ports["prod"]...) < 1980 && min(var.external-ports["prod"]...) >= 1880
  #   error_message = "Internal port needs to be set to 1880 and external port betweeen '65535 and 0'"
  # }
}

locals {
  deployment = {
    nodered = {
      image           = var.docker-image["nodered"][terraform.workspace]
      container_count = length(var.external-ports["nodered"][terraform.workspace])
      int_port        = 1880
      ext_port        = var.external-ports["nodered"][terraform.workspace]
      container_path  = "/data"
    }
    influxdb = {
      image           = var.docker-image["influxdb"][terraform.workspace]
      container_count = length(var.external-ports["influxdb"][terraform.workspace])
      int_port        = 8086
      ext_port        = var.external-ports["influxdb"][terraform.workspace]
      container_path  = "/var/lib/influxdb"
    }
  }
}