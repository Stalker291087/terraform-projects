resource "docker_volume" "docker-container-volume" {
  count = var.volume_count
  name  = "${var.volume_name}-${count.index}"
  lifecycle {
    prevent_destroy = false
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir /home/jean/docker-projects/backups/"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "sleep 5s && sudo tar -czvf /home/jean/docker-projects/backups/${self.name}.tar.gz ${self.mountpoint}/"
    on_failure = continue
  }
}