resource "docker_image" "nodered-image" {
  name = "nodered/node-red:latest"

}

resource "docker_container" "nodered-container" {
  name  = "nodered"
  image = docker_image.nodered-image.image_id
  ports {
    internal = 1880
    external = 1880
  }
}