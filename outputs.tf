output "bucket_name" {
  value = aws_s3_bucket.drift_test.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.drift_test.arn
}