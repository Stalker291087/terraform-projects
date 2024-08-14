# ---- networking/outputs.tf ----

output "vpc-id" {
  description = "ID of the VPC"
  value       = aws_vpc.aws-vpc.id
}

output "security-groups-id" {
  description = "ID of the security groups"
  value       = aws_security_group.kube-sg["rds"].id
}

output "db-subnet-group-name" {
  description = "Name of the subnet group name for RDS"
  value       = aws_db_subnet_group.kube_subnetgroup[0].name
}

output "public-security-groups-id" {
  description = "ID of the public security groups"
  value       = aws_security_group.kube-sg["public"].id
}

output "public-subnets" {
  description = "Public Subnets"
  value       = aws_subnet.public_subnets.*.id
}