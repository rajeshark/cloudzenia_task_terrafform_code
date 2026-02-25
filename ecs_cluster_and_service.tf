resource "aws_ecs_cluster" "cloudzenia_cluster" {
    name="cloudzenia-ecs-cluster"
    tags={
        Name="cloudzenia-ecs-cluster"
    }
}
resource "aws_ecs_service" "wordpress_service" {
    name="wordpress-service"
    cluster=aws_ecs_cluster.cloudzenia_cluster.id
    task_definition = aws_ecs_task_definition.wordpress_task_cloudzenia.arn
    launch_type = "FARGATE"
    desired_count = 2

    network_configuration {
      subnets = [aws_subnet.private_subnet_1.id,aws_subnet.private_subnet_2.id]

    security_groups=[aws_security_group.ecs_sg_cloudzenia.id]
    assign_public_ip=false
}
load_balancer {
  target_group_arn = aws_lb_target_group.wordpress_targate.arn
  container_name ="wordpress"
  container_port = 80
}
depends_on = [ aws_lb_listener.default_listener ]

}

resource "aws_ecs_service" "custom_microservice_service" {
    name="custom-microservice-service"
    cluster=aws_ecs_cluster.cloudzenia_cluster.id
    task_definition = aws_ecs_task_definition.custom_microservice_task_cloudzenia.arn
    launch_type = "FARGATE"
    desired_count = 1

    network_configuration {
      subnets = [aws_subnet.private_subnet_1.id,aws_subnet.private_subnet_2.id]

    security_groups=[aws_security_group.ecs_sg_cloudzenia.id]
    assign_public_ip=false
}
load_balancer {
  target_group_arn = aws_lb_target_group.custom_micro_tg.arn
  container_name ="custom-microser"
  container_port = 3000
}
depends_on = [ aws_lb_listener.default_listener ]

}


