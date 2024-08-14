#---------------------------------
# Networking module variables
#---------------------------------
variable "aws_region" {
  description = "Default AWS region for resources to be deployed"
}

variable "vpc-cidr-block" {
  description = "CIDR for the AWS VPC"
}

variable "public_cidr_subnets" {
  type        = string
  description = "CIDR for public subnets"
}

variable "private_cidr_subnets" {
  type        = string
  description = "CIDR for private subnets"
}

variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets to be deployed"
}

variable "private_subnet_count" {
  type        = number
  description = "Number of private subnets to be deployed"
}

variable "max_no_subnets" {
  type        = number
  description = "Maximun number of subnets to be created"
}

variable "public_access_cidr_bloc" {
  type        = string
  description = "CIDR block for public access security group"
}
#---------------------------------
# Database module variable values 
#---------------------------------
variable "database-storage" {
  type = number
}

variable "database_db_engine_version" {
  type = string
}

variable "database_db_instance_class" {
  type = string
}
variable "database_db_username" {
  type      = string
  sensitive = true
}

variable "database_db_password" {
  type      = string
  sensitive = true
}

variable "database_db_name" {
  type = string
}

variable "database_db_skip_final_snapshot" {
  type = bool
}

variable "database_db_identifier" {
  type = string
}

#---------------------------------
# Loadbalancer module variable values 
#---------------------------------
variable "net_lb_name" {
  type = string
}

variable "lb_tg_port" {
  type = number
}

variable "lb_tg_protocol" {
  type = string
}

variable "lb_tg_healthy_threshold" {
  type = number
}

variable "lb_tg_unhealthy_threshold" {
  type = number
}

variable "lb_tg_timeout" {
  type = number
}

variable "lb_tg_interval" {
  type = number
}

variable "listener_port" {
  type = number
}

variable "listener_protocol" {
  type = string
}