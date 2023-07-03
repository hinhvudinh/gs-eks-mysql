# Environemnt variable
variable "resource_prefix"          {}

# Mysql variable
variable "mysql_engine_version"     {}
variable "mysql_instance_class"     {}
variable "mysql_db_name"            {}
variable "mysql_master_user_name"   {}
variable "mysql_port"               {}

# VPC variable
variable "vpc_id"                   {}
variable "subnet_id1"               {}
variable "subnet_id2"               {}