resource "aws_ecs_task_definition" "custom_microservice_task_cloudzenia" {
  family                   = "custom-microser-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "custom-microser"
      image     = "${aws_ecr_repository.custom_micro_repo.repo_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]

    }
  ])
}
