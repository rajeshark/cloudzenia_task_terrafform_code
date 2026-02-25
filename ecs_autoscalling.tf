resource "aws_appautoscaling_target" "wp_target" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.cloudzenia_cluster.name}/${aws_ecs_service.wordpress_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
resource "aws_appautoscaling_policy" "wp_cpu" {
  name               = "wp-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.wp_target.resource_id
  scalable_dimension = aws_appautoscaling_target.wp_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.wp_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 60

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
resource "aws_appautoscaling_policy" "wp_memory" {
  name               = "wp-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.wp_target.resource_id
  scalable_dimension = aws_appautoscaling_target.wp_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.wp_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 70

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}
