# Repository resource block
resource "github_repository" "github-repository" {
  name        = "repository-created-by-terraform"
  description = "Test Repo"
  visibility  = "public"
  auto_init   = true
}

# Readme file resource block
resource "github_repository_file" "readme-file" {
  repository          = github_repository.github-repository.name
  branch              = "main"
  file                = "README.md"
  content             = "# This reposiroty is for Infrastructure developers"
  commit_message      = "Adding new readme file"
  commit_author       = "Jean C Espinoza"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}