resource "aws_ecs_task_definition" "wordpress_task_cloudzenia" {
  family                   = "wordpress-website-task-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = aws_db_instance.wordpress_db_mysql_cloudzenia.address
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = var.db_name
        }
      ]

      secrets = [
        {
          name      = "WORDPRESS_DB_USER"
          valueFrom = "${aws_secretsmanager_secret.rds_secrets_db.arn}:username::"
        },
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = "${aws_secretsmanager_secret.rds_secrets_db.arn}:password::"
        }
      ]
    }
  ])
}