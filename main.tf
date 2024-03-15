
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "public" {
  count                   = var.public-count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.public-subnet_mask, count.index)
  availability_zone       = element(var.azs, count.index % length(var.azs)) // Ensure circular selection of availability zones
  map_public_ip_on_launch = true

  tags = merge(var.vpc_tags, {
    "Name" = "public-subnet-${count.index + 1}-${element(var.azs, count.index % length(var.azs))}"
  })
}

resource "aws_subnet" "private" {
  count             = var.private-count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.private-subnet_mask, count.index + 2) // Starting index from 2 for private subnets
  availability_zone = element(var.azs, count.index % length(var.azs)) // Ensure circular selection of availability zones

  tags = merge(var.vpc_tags, {
    "Name" = "private-subnet-${count.index + 1}-${element(var.azs, count.index % length(var.azs))}"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

}

resource "aws_nat_gateway" "nat" {
  #    count = var.environment == "prod" ? length(var.azs) : 0 # Create NAT gateways only for prod 
  count         = var.nat-count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.private[count.index].id
  tags = {
    "Name" = "${var.environment}-nat-gateway-${count.index + 1}-${element(var.azs, count.index)}"
  }
}

resource "aws_eip" "nat" {
  #    count = var.environment == "prod" ? length(var.azs) : 0 
  count = var.nat-count
  tags = {
    "Name" = "${var.environment}-nat-gateway-ip-${count.index + 1}-${element(var.azs, count.index)}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_default_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_assoc" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_default_route_table.default.id
}

# tag the default route table as public
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.main.id

  tags = merge(var.vpc_tags, {
    "Name" = "private-rt-${count.index + 1}-${element(var.azs, count.index)}"
  })
}

resource "aws_route" "private_subnet_route" {
  #    count                  = var.environment == "prod" ? length(var.azs) : 0
  count                  = length(var.azs)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  #    nat_gateway_id         = var.environment == "prod" ? clear.nat[count.index].id : null
  nat_gateway_id = aws_nat_gateway.nat[count.index].id
}

resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}


resource "aws_security_group" "sg" {
  name        = "${var.environment}-${var.security_group}"
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.main.id
  depends_on = [
    aws_vpc.main
  ]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Environment = var.environment
  }
}

