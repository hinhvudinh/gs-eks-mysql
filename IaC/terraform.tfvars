# Environemnt variable assignment
aws_region      = "us-east-2"
resource_prefix = "vdh"

# mysql variable assignment
mysql_engine_version   = "8.0.32"
mysql_instance_class   = "db.t3.micro"
mysql_db_name          = "admin"
mysql_master_user_name = "admin"
mysql_port             = "3306"

# EKS variable assignment
cluster_name      = "eks-cluster"
cluster_node_name = "eks-node"
node_type         = ["t3.small"]
node_desired_size = 2
node_min_size     = 2
node_max_size     = 2