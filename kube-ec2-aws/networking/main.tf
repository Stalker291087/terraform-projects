# ---- networking/main.terraform ----

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "aws-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name       = "vpc-kubernetes-project-${random_integer.random.id}"
    Managed_by = "Terraform"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.aws-vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name       = "public-subnet-${count.index + 1}"
    Managed_by = "Terraform"
  }
}

resource "aws_route_table_association" "kube-public" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.kube_public_rt.id
}

resource "aws_subnet" "private_subnet" {
  count                   = var.private_subnet_count
  vpc_id                  = aws_vpc.aws-vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name       = "private-subnet-${count.index + 1}"
    Managed_by = "Terraform"
  }
}

resource "aws_internet_gateway" "kube_igw" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name       = "kubernetes-vpc-igw"
    Managed_by = "Terraform"
  }
}

resource "aws_route_table" "kube_public_rt" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    Name       = "kube-public-rtc"
    Managed_by = "Terraform"
  }
}

resource "aws_route" "default_rt" {
  route_table_id         = aws_route_table.kube_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kube_igw.id
}

resource "aws_default_route_table" "kube_private_rt" {
  default_route_table_id = aws_vpc.aws-vpc.default_route_table_id

  tags = {
    Name       = "kube_private"
    Managed_by = "Terraform"
  }
}

resource "aws_security_group" "kube-sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.aws-vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Managed_by = "Terraform"
  }
}

resource "aws_db_subnet_group" "kube_subnetgroup" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "kube-rds-subnet-group"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Name = "kube-rds-sng"
  }
}