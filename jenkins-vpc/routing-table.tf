resource "aws_route_table" "kthamel-ec2-private-routing" {
  vpc_id = aws_vpc.kthamel-ec2-vpc.id
  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.kthamel-ec2-nat-gw.id
      carrier_gateway_id         = ""
      core_network_arn           = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      ipv6_cidr_block            = null
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]
  tags = local.common_tags
}

resource "aws_route_table" "kthamel-ec2-public-routing" {
  vpc_id = aws_vpc.kthamel-ec2-vpc.id
  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      core_network_arn           = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = aws_internet_gateway.kthamel-ec2-igw.id
      ipv6_cidr_block            = null
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]
  tags = local.common_tags
}

resource "aws_route_table_association" "kthamel-ec2-rt-association-0" {
  subnet_id      = aws_subnet.kthamel-ec2-subnet-0.id
  route_table_id = aws_route_table.kthamel-ec2-public-routing.id
}

resource "aws_route_table_association" "kthamel-ec2-rt-association-1" {
  subnet_id      = aws_subnet.kthamel-ec2-subnet-1.id
  route_table_id = aws_route_table.kthamel-ec2-private-routing.id
}

resource "aws_route_table_association" "kthamel-ec2-rt-association-2" {
  subnet_id      = aws_subnet.kthamel-ec2-subnet-2.id
  route_table_id = aws_route_table.kthamel-ec2-private-routing.id
}

resource "aws_route_table_association" "kthamel-ec2-rt-association-3" {
  subnet_id      = aws_subnet.kthamel-ec2-subnet-3.id
  route_table_id = aws_route_table.kthamel-ec2-private-routing.id
}