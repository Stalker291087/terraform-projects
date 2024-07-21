output "clone-urls" {
  value       = { for i in github_repository.github-repository : i.name => [i.ssh_clone_url, i.http_clone_url] }
  description = "Repository clone URLs"
  sensitive   = false
}