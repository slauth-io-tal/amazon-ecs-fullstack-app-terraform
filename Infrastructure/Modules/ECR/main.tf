# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*=========================================
      AWS Elastic Container Repository
==========================================*/

resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"
  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/ECR/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "6f748b6e-bac4-4e26-a7bf-fbe93f46191a"
  }
}