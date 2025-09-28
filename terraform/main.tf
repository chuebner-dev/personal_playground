resource "aws_s3_bucket" "this" {
  bucket = "tf-oidc-example-bucket-${var.environment}"
}