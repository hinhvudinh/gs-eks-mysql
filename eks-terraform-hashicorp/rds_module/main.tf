resource "aws_db_instance" "terra" {
  identifier             = "${var.resource_prefix}-mydb"
  allocated_storage      = 10
  engine                 = "mariadb"
  engine_version         = "10.5.12"
  instance_class         = var.mariadb_instance_class
  db_name                = "my_maria"
  username               = var.mariadb_master_user_name
  password               = random_string.password.result
  skip_final_snapshot    = true
  apply_immediately      = true
  db_subnet_group_name   = aws_db_subnet_group.terra.id
}
 
resource "aws_db_subnet_group" "terra" {
  name        = "${var.resource_prefix}-rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = [var.subnet_id1, var.subnet_id2]
}
 
resource "random_string" "password" {
  length  = 10
  special = false
}