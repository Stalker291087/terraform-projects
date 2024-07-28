docker-image = {
  "dev"  = "nodered/node-red:latest"
  "prod" = "nodered/node-red:4.0.2-22-minimal"
}
external-ports = {
  "dev"  = [1980]
  "prod" = [1880]
}
internal-ports      = 1880
container-name      = "node-red"
host-data-path      = "/home/jean/docker-containers/node-red/"
data-directory-name = "noderedvol1"