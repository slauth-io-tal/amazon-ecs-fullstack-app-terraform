# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*====================================
      AWS ECS Task definition
=====================================*/

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "task-definition-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = <<DEFINITION
    [
      {
        "logConfiguration": {
            "logDriver": "awslogs",
            "secretOptions": null,
            "options": {
              "awslogs-group": "/ecs/task-definition-${var.name}",
              "awslogs-region": "${var.region}",
              "awslogs-stream-prefix": "ecs"
            }
          },
        "cpu": 0,
        "image": "${var.docker_repo}",
        "name": "${var.container_name}",
        "networkMode": "awsvpc",
        "portMappings": [
          {
            "containerPort": ${var.container_port},
            "hostPort": ${var.container_port}
          }
        ]
        }
    ]
    DEFINITION
  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/ECS/TaskDefinition/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "098c8ddf-91f0-4bf7-9605-2cc2c755f5a4"
  }
}

# ------- CloudWatch Logs groups to store ecs-containers logs -------
resource "aws_cloudwatch_log_group" "TaskDF-Log_Group" {
  name              = "/ecs/task-definition-${var.name}"
  retention_in_days = 30
  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/ECS/TaskDefinition/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "f783002c-9da2-4e65-90b3-738f72c539d0"
  }
}