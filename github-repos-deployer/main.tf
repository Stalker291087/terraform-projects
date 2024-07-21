data "github_user" "github_current_user" {
  username = ""
}

resource "random_id" "random" {
  byte_length = 2
}

# Repository resource block
resource "github_repository" "github-repository" {
  for_each    = var.repositories
  name        = "slothsultions-repo-${each.key}"
  description = "${each.value.lang} Repository"
  visibility  = var.env == "prod" ? "private" : "public"
  auto_init   = true

  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf /home/jean/git_repositories/${self.name}"
  }
}

# Fake resource
resource "terraform_data" "provisioner_gitclone" {
  for_each   = var.repositories
  depends_on = [github_repository.github-repository, github_repository_file.readme-file, github_repository_file.index-file]

  provisioner "local-exec" {
    command = "git clone ${github_repository.github-repository[each.key].name} /home/jean/git_repositories"
  }

}

# Readme file resource block
resource "github_repository_file" "readme-file" {
  for_each            = var.repositories
  repository          = github_repository.github-repository[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = "# This reposiroty is for ${each.value.lang} developers - ${var.env}"
  commit_message      = "Adding new readme file"
  commit_author       = data.github_user.github_current_user.name
  commit_email        = data.github_user.github_current_user.email
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}

resource "github_repository_file" "index-file" {
  for_each            = var.repositories
  repository          = github_repository.github-repository[each.key].name
  branch              = "main"
  file                = "index.html"
  content             = "Hello ${each.value.lang}"
  commit_message      = "Adding index.html file"
  commit_author       = data.github_user.github_current_user.name
  commit_email        = data.github_user.github_current_user.email
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}