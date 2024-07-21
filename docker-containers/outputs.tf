output "container_id" {
  description = "Container id:"
  value = "${docker_container.docker-container.id} at port -> ${docker_container.docker-container.ports[0].external}"
}