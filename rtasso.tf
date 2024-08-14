resource "aws_route_table_association" "subnet1" {
  subnet_id = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.myrt.id
}

resource "aws_route_table_association" "subnet2" {
  subnet_id = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.myrt.id
}