output "container_id" {
  description = "Container id:"
  value = "${docker_container.docker-container.id} (${docker_container.docker-container.name}) at port -> ${docker_container.docker-container.ports[0].external}"
}