## RDS(Mysql)
output "mysql_endpoint" {
  description = "The connection endpoint"
  value       = element(split(":", aws_db_instance.infra.endpoint),0)
}

output "mysql_db_name"{
  description = "The database name"
  value = aws_db_instance.infra.db_name
}

output "mysql_user_name" {
  description = "The master username for the database"
  value       = aws_db_instance.infra.username
}

output "mysql_user_password" {
  description = "The master password for the database"
  value       = random_string.password.result
}