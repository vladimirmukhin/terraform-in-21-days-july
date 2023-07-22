resource "aws_security_group" "private" {
  name        = "${var.env_code}-private"
  description = "Private security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from laod balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.load_balancer_sg] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-private"
  }
}

resource "aws_launch_configuration" "main" {
  name_prefix          = "${var.env_code}-"
  image_id             = var.ami_id
  instance_type        = "t3.micro"
  security_groups      = [aws_security_group.private.id]
  user_data            = file("${path.module}/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.main.name
}

resource "aws_autoscaling_group" "main" {
  name = var.env_code

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  target_group_arns    = [var.target_group_arn]
  launch_configuration = aws_launch_configuration.main.name
  vpc_zone_identifier  = var.private_subnet_id

  tag {
    key                 = "Name"
    value               = var.env_code
    propagate_at_launch = true
  }
}
