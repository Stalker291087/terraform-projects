#-------------------------- 
#---- database/main.tf ----
#--------------------------

resource "aws_db_instance" "kube-rds" {
  allocated_storage      = var.db_storage
  engine                 = "mysql"
  db_name                = var.db_name
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = var.db_identifier
  skip_final_snapshot    = var.db_skip_final_snapshot

  tags = {
    Name       = "kube-rds-instance"
    Managed_by = "Terraform"
  }
}