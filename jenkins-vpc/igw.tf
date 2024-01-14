resource "aws_internet_gateway" "kthamel-ec2-igw" {
  vpc_id = aws_vpc.kthamel-ec2-vpc.id

  tags = local.common_tags
}