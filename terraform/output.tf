output "aws_s3_bucket_website_endpoint" {
  value = "http://${aws_s3_bucket_website_configuration.bucket-website-configuration.website_endpoint}"
}