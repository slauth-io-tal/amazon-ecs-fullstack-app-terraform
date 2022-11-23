# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================
      AWS S3 resources
============================*/

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true
  tags = {
    Name      = var.bucket_name
    yor_trace = "876005d0-93d9-4ca1-b7d4-5ebaa9f9f8a7"
  }
}