terraform {
  cloud {

    organization = "SlothSolutionsCR"

    workspaces {
      name = "dev"
    }
  }
}