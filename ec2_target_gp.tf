resource "aws_lb_target_group" "instance_tg" {
    name="instance-tg"
    port=80
    protocol = "HTTP"
    vpc_id = aws_vpc.cloudzenia_vpc.id

    health_check {
      
    path="/"
    protocol = "HTTP"
    timeout = 5
    matcher = "200"
    interval = 30
    healthy_threshold = 2
    unhealthy_threshold = 2
    }
  
}
resource "aws_lb_target_group" "docker_tg" {
    name="docker-tg"
    port=80
    protocol = "HTTP"
    vpc_id = aws_vpc.cloudzenia_vpc.id

    health_check {
      
    path="/"
    protocol = "HTTP"
    timeout = 5
    matcher = "200"
    interval = 30
    healthy_threshold = 2
    unhealthy_threshold = 2
    }
  
}
resource "aws_lb_target_group_attachment" "instance_ec2_1" {
  target_group_arn = aws_lb_target_group.instance_tg.arn
  target_id        = aws_instance.cloudzenia_ec2_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "instance_ec2_2" {
  target_group_arn = aws_lb_target_group.instance_tg.arn
  target_id        = aws_instance.cloudzenia_ec2_2.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "docker_ec2_1" {
  target_group_arn = aws_lb_target_group.docker_tg.arn
  target_id        = aws_instance.cloudzenia_ec2_1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "docker_ec2_2" {
  target_group_arn = aws_lb_target_group.docker_tg.arn
  target_id        = aws_instance.cloudzenia_ec2_2.id
  port             = 80
}