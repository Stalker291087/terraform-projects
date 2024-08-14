locals {
  private-subnets = [for octect in range(1, 255, 2) : cidrsubnet(var.private_cidr_subnets, 8, octect)]

  public-subnets = [for octect in range(2, 255, 2) : cidrsubnet(var.private_cidr_subnets, 8, octect)]
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.public_access_cidr_bloc]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.public_access_cidr_bloc]
        }
      }
    }
    rds = {
      name        = "rds_sg"
      description = "Security group for rds private access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [var.public_access_cidr_bloc]
        }
      }
    }
  }
}
