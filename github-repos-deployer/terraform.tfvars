repo-max = 4
env      = "dev"
repositories = {
  infrastructure = {
    lang     = "terraform"
    filename = "main.tf"
  },
  backend = {
    lang     = "python"
    filename = "main.py"
  }
}