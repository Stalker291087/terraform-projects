variable "lb_name" {
  type = string
}

variable "lb_public_subnets" {
  type = list(string)
}

variable "lb_security_groups" {
  type = list(string)
}

variable "tg_port" {
  type = number
}

variable "tg_protocol" {
  type = string
}

variable "tg_vpc_id" {
  type = string
}

variable "tg_healthy_threshold" {
  type = number
}

variable "tg_unhealthy_threshold" {
  type = number
}

variable "tg_timeout" {
  type = number
}

variable "tg_interval" {
  type = number
}

variable "lb_listener_port" {
  type = number
}
variable "lb_listener_protocol" {
  type = string
}