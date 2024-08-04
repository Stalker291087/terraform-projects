locals {
  deployment = {
    nodered = {
      image           = var.docker-image["nodered"][terraform.workspace]
      container_count = length(var.external-ports["nodered"][terraform.workspace])
      int_port        = 1880
      ext_port        = var.external-ports["nodered"][terraform.workspace]
      volumes = [
        { container_path_each = "/data" }
      ]
    }
    influxdb = {
      image           = var.docker-image["influxdb"][terraform.workspace]
      container_count = length(var.external-ports["influxdb"][terraform.workspace])
      int_port        = 8086
      ext_port        = var.external-ports["influxdb"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/influxdb" }
      ]
    }
    grafana = {
      image           = var.docker-image["grafana"][terraform.workspace]
      container_count = length(var.external-ports["grafana"][terraform.workspace])
      int_port        = 3000
      ext_port        = var.external-ports["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}