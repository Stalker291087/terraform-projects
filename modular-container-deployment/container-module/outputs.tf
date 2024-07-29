output "container-details" {
  description = "Docker containers and external ports."
  value       = [for containers in docker_container.docker-container[*] : join(":", [containers.name], [containers.network_data[0].ip_address], [containers.ports[0]["external"]])]
}