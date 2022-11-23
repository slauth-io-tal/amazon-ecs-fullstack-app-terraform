# Copyright Slauth.io, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================================
      AWS CloudTrail resources
============================================*/

resource "aws_cloudtrail" "slauth_events" {
  name                          = "slauth-events"
  s3_bucket_name                = aws_s3_bucket.slauth_event_logs.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3"]
    }

    data_resource {
      type   = "AWS::DynamoDB::Table"
      values = ["arn:aws:dynamodb"]
    }
  }
  tags = {
    yor_trace = "cb9bd6eb-45ac-4692-ab9c-33b978f04c50"
  }
}

resource "aws_s3_bucket" "slauth_event_logs" {
  bucket        = var.event_logs_bucket_name
  force_destroy = true
  tags = {
    yor_trace = "49eb491e-fddb-4b1f-ac92-111f8e582662"
  }
}

resource "aws_s3_bucket_policy" "slauth_event_logs" {
  bucket = aws_s3_bucket.slauth_event_logs.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.slauth_event_logs.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.slauth_event_logs.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}