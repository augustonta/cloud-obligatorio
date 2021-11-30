###Load balancer
resource "aws_lb" "app_lb" {
  name               = "entry-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]

  enable_deletion_protection = false


  tags = {
    Name = "ecomme_lb"
  }
}

##Target group
resource "aws_lb_target_group" "app_tg" {
  name        = "app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.ecomme-ae-mh.id
  tags = {
    Name      = "ecomme_tg"
  }
  depends_on = [aws_lb.app_lb]
}

resource "aws_lb_listener" "app_http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
