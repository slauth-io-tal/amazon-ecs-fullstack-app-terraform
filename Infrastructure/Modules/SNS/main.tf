# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*====================================================
      AWS SNS topic for deployment notifications
=====================================================*/

resource "aws_sns_topic" "sns_notifications" {
  name = var.sns_name
  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/SNS/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "a0704b1a-3dff-4bec-a0ec-b7ef25727354"
  }
}