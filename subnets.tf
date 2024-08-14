resource "aws_subnet" "mysubnet1" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-la"
    tags = {
      Name = "subnet-1"
    }
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
}

resource "aws_subnet" "mysubnet2" {
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-lb"
    tags = {
      Name = "subnet-2"
    }
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
}