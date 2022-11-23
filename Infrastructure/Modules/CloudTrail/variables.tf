# Copyright Slauth.io, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "event_logs_bucket_name" {
  description = "The name of your S3 bucket designated for CloudTrail event logs"
  type        = string
  default     = "slauth-event-logs"
}