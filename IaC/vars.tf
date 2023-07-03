variable "aws_region" {
  default     = null
  type        = string
  description = "AWS region"
}

variable "resource_prefix" {
  default     = null
  type        = string
  description = "resource prefix"
}

### Define Mysql variable ------------------------------------------------------
variable "mysql_engine_version" {
  default     = "8.0.32"
  type        = string
  description = "Mysql engine verion"
}

variable "mysql_instance_class" {
  default     = "t3.small"
  type        = string
  description = "Mysql instance size"
}

variable "mysql_db_name" {
  default     = "admin"
  type        = string
  description = "Mysql db name"
}

variable "mysql_master_user_name" {
  default     = "admin"
  type        = string
  description = "Mysql master user name"
}

variable "mysql_port" {
  default     = "3306"
  type        = string
  description = "Mysql port"
}

### Define EKS variables -------------------------------------------------------
variable "cluster_name" {
  default     = "eks-cluster"
  type        = string
  description = "eks cluster name"
}

variable "cluster_node_name" {
  default     = "eks-node"
  type        = string
  description = "eks cluster node name"
}

variable "node_type" {
  default     = ["t3.small"]
  type        = list(any)
  description = "eks cluster node type"
}

variable "node_desired_size" {
  default     = 2
  type        = number
  description = "eks-node desired size"
}

variable "node_max_size" {
  default     = 2
  type        = number
  description = "eks- node maxize"
}

variable "node_min_size" {
  default     = 2
  type        = number
  description = "eks-node desired size"
}