data "aws_availability_zones" "available" {}

resource "aws_vpc" "infra" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "${var.resource_prefix}-infraform-vpc"
  }
}

resource "aws_subnet" "public" {
  count = 2               # Repeat the code block below twice

  vpc_id                  = aws_vpc.infra.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.resource_prefix}-infraform-public-subnet${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count = 2               # Repeat the code block below twice

  vpc_id                  = aws_vpc.infra.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.1${count.index}.0/24"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "${var.resource_prefix}-infraform-private-subnet${count.index+1}"
  }
}

resource "aws_internet_gateway" "infra" {
  vpc_id = aws_vpc.infra.id

  tags = {
    Name = "${var.resource_prefix}-infraform-eks-ig"
  }
}

resource "aws_nat_gateway" "infra" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${element(aws_subnet.public.*.id,0)}"

  tags = {
    Name = "${var.resource_prefix}-infraform-nat-gw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.infra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra.id
  }

  tags = {
    "Name" = "${var.resource_prefix}-infraform-public-route"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.infra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.infra.id
  }

  tags = {
    "Name" = "${var.resource_prefix}-infraform-private-route",
  }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = 2

  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "${var.resource_prefix}-infraform-NAT"
  }
}