output "application-access" {
  value = { for containers in docker_container.docker-container[*] : containers.name => join(":", [containers.network_data[0].ip_address], [containers.ports[0]["external"]]) }
}