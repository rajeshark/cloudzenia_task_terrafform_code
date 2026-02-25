# this alb for the task-1 such as word press and custom microservice
resource "aws_lb" "cloudzenia_alb" {
    name="cloudzenia-alb"
    load_balancer_type = "application"
    subnets=[aws_subnet.public_subnet_1.id,aws_subnet.public_subnet_2.id]
    security_groups = [aws_security_group.alb_sg_wordpress_and_custom_micro.id]
    enable_deletion_protection = false
    tags={
        Name="cloudzenia_alb"
    }
}
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.cloudzenia_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  certificate_arn   = aws_acm_certificate.ssl_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_targate.arn
  }
}
resource "aws_lb_listener" "default_listener" {
  load_balancer_arn = aws_lb.cloudzenia_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
#host based rule
resource "aws_lb_listener_rule" "wordpress_listener_rule" {
    listener_arn= aws_lb_listener.https_listener.arn
    priority=1

    condition{
        host_header{
            values=["wordpress.${var.domain_name}"]
        }
    }
    action{
        type="forward"
        target_group_arn=aws_lb_target_group.wordpress_targate.arn
    }
}
resource "aws_lb_listener_rule" "microservice_listener_rule" {
    listener_arn = aws_lb_listener.https_listener.arn
    priority=2

    condition{
        host_header{
            values=["microservice.${var.domain_name}"]
        }
    }
    action{
        type="forward"
        target_group_arn=aws_lb_target_group.custom_micro_tg.arn
    }
  
}


# alb for task 2 such as ec2 instance

resource "aws_lb" "alb_ec2" {
    name="alb-for-ec2"
    load_balancer_type = "application"
    subnets=[aws_subnet.public_subnet_1.id,aws_subnet.public_subnet_2.id]
    security_groups = [aws_security_group.alb_sg_ec2.id]
    enable_deletion_protection = false
    tags={
        Name="alb_for_ec2"
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_ec2.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb_ec2.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_tg.arn
  }
}
resource "aws_lb_listener_rule" "alb_instance_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  condition {
    host_header {
      values = ["ec2-alb-instance.${var.domain_name}"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_tg.arn
  }
}
resource "aws_lb_listener_rule" "alb_docker_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 2

  condition {
    host_header {
      values = ["ec2-alb-docker.${var.domain_name}"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.docker_tg.arn
  }
}