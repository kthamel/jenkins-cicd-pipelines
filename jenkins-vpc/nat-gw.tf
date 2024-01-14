resource "aws_eip" "kthamel-ec2-elastic-ip" {
  domain = "vpc"

  tags = local.common_tags
}

resource "aws_nat_gateway" "kthamel-ec2-nat-gw" {
  allocation_id = aws_eip.kthamel-ec2-elastic-ip.id
  subnet_id     = aws_subnet.kthamel-ec2-subnet-0.id

  depends_on = [aws_internet_gateway.kthamel-ec2-igw]

  tags = local.common_tags
}