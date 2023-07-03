output "vpc_id" {
  value = aws_vpc.infra.id
}

output "private_subnet_id" {
  value = [aws_subnet.private.*.id[0], aws_subnet.private.*.id[1]]
}