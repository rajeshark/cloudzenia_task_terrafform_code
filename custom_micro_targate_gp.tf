resource "aws_lb_target_group" "custom_micro_tg" {
    name="custom-micro-tg"
    port=3000
    protocol="HTTP"
    target_type="ip"
    vpc_id = aws_vpc.cloudzenia_vpc.id
    health_check {
      path="/"
      protocol="HTTP"
      matcher="200"
      interval=30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    tags={
        Name="custom-micro-tg"
    }

  
}