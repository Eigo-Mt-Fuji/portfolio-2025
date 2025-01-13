resource "aws_ecs_cluster" "fluentbit" {
  name = "${var.env}-logcollector"
  depends_on = [ aws_ecr_repository.fluentbit, null_resource.default]
}
resource "aws_ecs_task_definition" "fluentbit" {
  family                   = "${var.env}-logcollector-task"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "fluentbit"
      # image     = "fluent/fluent-bit:3.1.3"
      image = "${aws_ecr_repository.fluentbit.repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 10224
        }
      ]
      environment = [
        {
          name  = "TARGET_S3_BUCKET"
          value = var.target_s3_bucket
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "logs"
          containerPath = "/fluent-bit/logs"
        }
      ]
    }
  ])

  volume {
    name = "logs"
    host_path = "/var/logs/fluent-bit"
  }
}

resource "aws_ecs_service" "fluentbit_service" {
  name            = "${var.env}-logcollector-service"
  cluster         = aws_ecs_cluster.fluentbit.id
  task_definition = aws_ecs_task_definition.fluentbit.arn
  desired_count   = 1
  launch_type     = "EC2"
#   network_configuration {
#     subnets         = var.private_subnets
#     security_groups = var.security_groups
#   }
  load_balancer {
    target_group_arn = aws_lb_target_group.nlb_tg.arn
    container_name   = "fluentbit"
    container_port   = 10224
  }
}
