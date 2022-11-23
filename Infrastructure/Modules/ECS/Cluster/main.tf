# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*=============================
        AWS ECS Cluster
===============================*/

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "Cluster-${var.name}"
  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/ECS/Cluster/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "9e65cb7d-af80-4b46-9567-15427e9639bd"
  }
}