resource "aws_ecs_task_definition" "ecomme" {
  family                   = "ecomme"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::492371673846:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name  = "gitcomme"
      image = "492371673846.dkr.ecr.us-east-1.amazonaws.com/gitcomme:latest"

      essential = true
      
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
          "mountPoints": [
          {
              "containerPath": "/var/www/html/documents",
              "sourceVolume": "efs-img"
              "readOnly" : false
          }
      ],
    "environment": [
            {"name": "DBHOST", "value": aws_db_instance.mysqlecomme.address}
        ],
    } 
  ])
    volume {
    name = "efs-img"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.efs-img.id
      root_directory          = "/"
    }
  }
}