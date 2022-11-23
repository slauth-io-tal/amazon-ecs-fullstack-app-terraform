# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*=======================================
      Amazon Dynamodb resources
========================================*/

resource "aws_dynamodb_table" "dynamodb_table" {
  name         = var.name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key
  range_key    = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  tags = {
    git_commit           = "dcb66fd491dac167d82574497ed2bcb2569e104f"
    git_file             = "Infrastructure/Modules/Dynamodb/main.tf"
    git_last_modified_at = "2021-05-18 09:39:26"
    git_last_modified_by = "burkhardtmarina@gmail.com"
    git_modifiers        = "burkhardtmarina"
    git_org              = "slauth-io-tal"
    git_repo             = "amazon-ecs-fullstack-app-terraform"
    yor_trace            = "a8a161ce-0ab1-4771-aeb3-ddf28b2b2d9f"
  }
}