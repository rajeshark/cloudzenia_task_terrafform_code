resource "aws_lb_target_group" "wordpress_targate" {
    name="wordpress-tg"
    port=80
    protocol="HTTP"
    target_type="ip"
    vpc_id = aws_vpc.cloudzenia_vpc.id
    health_check {
      path="/"
      protocol="HTTP"
      matcher="200-399"
      interval=30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    tags={
        Name="wordpress-tg"
    }
}