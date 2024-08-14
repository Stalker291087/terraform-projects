# ---- root/main.tf ----

resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
  count = var.max_no_subnets
}

module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc-cidr-block
  security_groups      = local.security_groups
  access_cidrs         = var.public_access_cidr_bloc
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  public_cidrs         = local.public-subnets
  private_cidrs        = local.private-subnets
  availability_zones   = random_shuffle.az_list[0].result
  db_subnet_group      = true
}

# module "database" {
#   source                 = "./database"
#   db_storage             = var.database-storage
#   db_engine_version      = var.database_db_engine_version
#   db_instance_class      = var.database_db_instance_class
#   db_name                = var.database_db_name
#   db_username            = var.database_db_username
#   db_password            = var.database_db_password
#   db_subnet_group_name   = module.networking.db-subnet-group-name
#   vpc_security_group_ids = [module.networking.security-groups-id]
#   db_identifier          = var.database_db_identifier
#   db_skip_final_snapshot = var.database_db_skip_final_snapshot
# }

module "loadbalancing" {
  source                 = "./loadbalancing"
  lb_name                = var.net_lb_name
  lb_security_groups     = [module.networking.public-security-groups-id]
  lb_public_subnets      = [module.networking.security-groups-id]
  tg_port                = var.lb_tg_port
  tg_protocol            = var.lb_tg_protocol
  tg_vpc_id              = module.networking.vpc-id
  tg_healthy_threshold   = var.lb_tg_healthy_threshold
  tg_unhealthy_threshold = var.lb_tg_unhealthy_threshold
  tg_timeout             = var.lb_tg_timeout
  tg_interval            = var.lb_tg_interval
  lb_listener_port       = var.listener_port
  lb_listener_protocol   = var.listener_protocol
}