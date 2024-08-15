resource "aws_launch_configuration" "one" {
    image_id = "ami-0b4f379183e5706b9"
    instance_type = "t2.micro"
    key_name = "sai"
    security_groups = [aws_security_group.mysg.id]
       user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install httpd -y
        sudo systemctl start httpd
        sudo systemctl enable httpd
        echo "<html><body><h1> Welcome to Terraform Scaling. </h1></body></html>" | sudo tee /var/www/html/index.html
    EOF
}

resource "aws_elb" "myelb" {
    name = "Terraform-lb"
    security_groups = [aws_security_group.mysg.id]
    subnets = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
    listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
    }
    tags = {
      name = "terraform-lb"
    }
}

resource "aws_autoscaling_group" "two" {
    name = "my-asg"
    launch_configuration = aws_launch_configuration.one.name
    min_size = 2
    max_size = 3
    desired_capacity = 2
    health_check_type = "EC2"
    load_balancers = [aws_elb.myelb.name]
    vpc_zone_identifier = [aws_subnet.mysubnet1.id,aws_subnet.mysubnet2.id]
  
}