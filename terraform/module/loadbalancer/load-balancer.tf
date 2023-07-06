resource "aws_lb" "default" {
  name               = "tf-${var.api_name}-api-gateway"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
  security_groups = var.security_groups_id
  tags = {
    Name = "tf-${var.api_name}-api-gateway"
    Provider = "terraform"
    Environment = var.api_name
  }
}

resource "aws_lb_target_group" "https" {
  name        = "tf-${var.api_name}-https"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    port                = "443"
    protocol            = "HTTPS"
    matcher             = "403"
  }
  tags = {
    Name = "tf-${var.api_name}-https"
    Provider = "terraform"
    Environment = var.api_name
  }
}

resource "aws_lb_target_group_attachment" "https_1" {
  depends_on = [aws_lb_target_group.https, aws_lb.default]
  target_group_arn = aws_lb_target_group.https.arn
  target_id        = var.vpc_ips[0]
}


resource "aws_lb_target_group_attachment" "https_2" {
  depends_on = [aws_lb_target_group.https, aws_lb.default]
  target_group_arn = aws_lb_target_group.https.arn
  target_id        = var.vpc_ips[1]
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.default.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn
  tags = {
    Name = "tf-${var.api_name}-api-gateway"
    Provider = "terraform"
    Environment = var.api_name
  }
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"
  tags = {
    Name = "tf-${var.api_name}-api-gateway"
    Provider = "terraform"
    Environment = var.api_name
  }
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

