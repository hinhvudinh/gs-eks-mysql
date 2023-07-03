resource "aws_db_subnet_group" "infra" {
  name        = "${var.resource_prefix}-rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = [var.subnet_id1, var.subnet_id2]
}
 
resource "random_string" "password" {
  length  = 10
  special = false
}

resource "aws_db_parameter_group" "infra" {
  name = "${var.resource_prefix}infraparameter"
  family = "mysql8.0"
  
  parameter {
    name = "max_connections"
    value = "1000"
  }
}

resource "aws_db_instance" "infra" {
  identifier             = "${var.resource_prefix}-mydb"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = var.mysql_engine_version
  instance_class         = var.mysql_instance_class
  db_name                = var.mysql_db_name
  username               = var.mysql_master_user_name
  password               = random_string.password.result
  skip_final_snapshot    = true
  apply_immediately      = true
  db_subnet_group_name   = aws_db_subnet_group.infra.id
  vpc_security_group_ids = ["${aws_security_group.infra.id}"]
}

resource "aws_security_group" "infra" {
  name        = "${var.resource_prefix}-infraform_rds_sg"
  description = "Infraform RDS Mysql sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.mysql_port
    to_port     = var.mysql_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
}