output "application-access" {
  value = flatten([for containers in module.docker-container[*]: containers])
}