resource "aws_ecs_cluster" "ecomme-ae-mh" {
  name = "ecomme-ae-mh"
  capacity_providers = ["FARGATE"]
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}