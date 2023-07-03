provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "./vpc_module"
  resource_prefix = var.resource_prefix
}

module "rds" {
  source = "./rds_module"

  resource_prefix        = var.resource_prefix
  mysql_instance_class   = var.mysql_instance_class
  mysql_master_user_name = var.mysql_master_user_name
  mysql_engine_version   = var.mysql_engine_version
  mysql_port             = var.mysql_port
  mysql_db_name          = var.mysql_db_name

  vpc_id     = module.vpc.vpc_id
  subnet_id1 = module.vpc.private_subnet_id[0]
  subnet_id2 = module.vpc.private_subnet_id[1]
}

module "eks" {
  source = "./eks_module"

  resource_prefix   = var.resource_prefix
  cluster_name      = var.cluster_name
  cluster_node_name = var.cluster_node_name
  node_type         = var.node_type
  node_desired_size = var.node_desired_size
  node_max_size     = var.node_max_size
  node_min_size     = var.node_min_size
  aws_region        = var.aws_region

  vpc_id     = module.vpc.vpc_id
  subnet_id1 = module.vpc.private_subnet_id[0]
  subnet_id2 = module.vpc.private_subnet_id[1]
}