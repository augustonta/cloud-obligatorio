resource "aws_ecs_service" "service_ecomme" {
  name            = "service_ecomme"
  task_definition = aws_ecs_task_definition.ecomme.arn
  cluster         = aws_ecs_cluster.ecomme-ae-mh.id
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets          = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_1.id]
    security_groups  = [aws_security_group.app_80.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "gitcomme"
    container_port   = 80
  }
}
