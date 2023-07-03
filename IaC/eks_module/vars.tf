# Environemnt variable
variable "aws_region"        {}
variable "resource_prefix"   {}

# EKS variable
variable "cluster_name"      {}
variable "cluster_node_name" {}
variable "node_type"         {}
variable "node_desired_size" {}
variable "node_max_size"     {}
variable "node_min_size"     {}

# VPC variable
variable "vpc_id"            {}
variable "subnet_id1"        {}
variable "subnet_id2"        {}