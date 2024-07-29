output "container-details" {
  description = "Docker containers and external ports."
  value       = flatten([for containers in module.docker-container[*].container-details : containers])
}