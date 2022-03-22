data "aws_availability_zones" "available" {
  state = "available"
}

# resource "aws_launch_template" "foobar" {
#   name_prefix   = "foobar"
#   image_id      = "ami-1a2b3c"
#   instance_type = "t2.micro"
# }

# resource "aws_autoscaling_group" "bar" {
#   availability_zones = ["us-east-1a"]
#   desired_capacity   = 1
#   max_size           = 1
#   min_size           = 1

#   launch_template {
#     id      = aws_launch_template.foobar.id
#     version = "$Latest"
#   }
# }

resource "aws_launch_configuration" "asg-launch-config-fiap-hmv" {
  image_id               = var.ec2_ami
  instance_type          = var.ec2_instance_type
  
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform & AWS ASG" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group" "fiap-hmv" {
  name = "terraform-fiap-hmv-sg"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb-sg" {
  name = "terraform-fiap-hmv-elb-sg"
  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Inbound HTTP from anywhere
  ingress {
    from_port   = var.elb_port
    to_port     = var.elb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "asg-fiap-hmv" {
  launch_configuration = aws_launch_configuration.asg-launch-config-fiap-hmv.id
  availability_zones   = [data.aws_availability_zones.available.names[0]]
  min_size             = var.min_size
  max_size             = var.max_size

  load_balancers       = [aws_elb.fiap-hmv.name]
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "terraform-asg-fiap-hmv"
    propagate_at_launch = true
  }

  tag {
    key                 = "Projeto"
    value               = var.projeto
    propagate_at_launch = true
  }

}

resource "aws_elb" "fiap-hmv" {
  name                  = "terraform-asg-fiap-hmv"
  security_groups       = [aws_security_group.elb-sg.id]
  availability_zones    = [data.aws_availability_zones.available.names[0]]

  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  # Adding a listener for incoming HTTP requests.
  listener {
    lb_port             = var.elb_port
    lb_protocol         = "http"
    instance_port       = var.server_port
    instance_protocol   = "http"
  }
}