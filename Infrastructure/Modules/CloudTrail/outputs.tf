# Copyright Slauth.io, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "slauth_events_trail_id" {
  value = aws_cloudtrail.slauth_events.id
}

output "slauth_events_trail_arn" {
  value = aws_cloudtrail.slauth_events.arn
}

output "slauth_event_logs_bucket_id" {
  value = aws_s3_bucket.slauth_event_logs.id
}

output "slauth_event_logs_bucket_arn" {
  value = aws_s3_bucket.slauth_event_logs.arn
}

output "slauth_event_logs_bucket_policy_id" {
  value = aws_s3_bucket_policy.slauth_event_logs.id
}

output "slauth_event_logs_bucket_policy_arn" {
  value = aws_s3_bucket_policy.slauth_event_logs.arn
}