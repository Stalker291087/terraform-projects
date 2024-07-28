output "container-details" {
  description = "Docker containers and external ports."
  value       = [for ports in docker_container.docker-container[*] : join(":", [ports.name], [ports.network_data[0].ip_address], [ports.ports[0]["external"]])]
}