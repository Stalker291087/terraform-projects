output "volume_output" {
  value = docker_volume.docker-container-volume[*].name
}