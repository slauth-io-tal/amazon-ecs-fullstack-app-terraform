# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*==========================
      AWS ECS Service
===========================*/

resource "aws_ecs_service" "ecs_service" {
  name                              = "Service-${var.name}"
  cluster                           = var.ecs_cluster_id
  task_definition                   = var.arn_task_definition
  desired_count                     = var.desired_tasks
  health_check_grace_period_seconds = 10
  launch_type                       = "FARGATE"

  network_configuration {
    security_groups = [var.arn_security_group]
    subnets         = [var.subnets_id[0], var.subnets_id[1]]
  }

  load_balancer {
    target_group_arn = var.arn_target_group
    container_name   = var.container_name
    container_port   = var.container_port
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    // to avoid changes generated by autoscaling or new CodeDeploy changes
    ignore_changes = [desired_count, task_definition, load_balancer]
  }

  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/ECS/Service/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "093bc8bb-1884-4a9b-bb7a-2fa9bae07374"
  }
}