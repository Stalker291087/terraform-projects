# ---- networking/variables.tf ----

variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(string)
}

variable "private_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_count" {
  type = number
}

variable "private_subnet_count" {
  type = number
}
variable "access_cidrs" {
  type = string
}

variable "security_groups" {
}

variable "db_subnet_group" {
  type = bool
}
