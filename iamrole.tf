resource "aws_iam_role" "ecs_task_execution_role" {
    name="ecstaskexecutionrolecloudzenia"
    assume_role_policy = jsonencode({
        Version="2012-10-17"
        Statement= [{
            Effect = "Allow"
            Principal={
                Service="ecs-tasks.amazonaws.com"
            }
            Action="sts:AssumeRole"
        }
        ]
    })
    tags={
        Name="ecstaskexecutionrolecloudzenia"
    }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
    role=aws_iam_role.ecs_task_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

  
}
resource "aws_iam_role_policy_attachment" "ecs_secrets_policy" {
    role=aws_iam_role.ecs_task_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"

  
}
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy_attachment" "cw_attach" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-cloudwatch-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}