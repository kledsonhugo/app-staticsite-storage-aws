# S3 BUCKET
resource "aws_s3_bucket" "b" {
    bucket = "static-site-kledson-basso"
}

# S3 BUCKET CONFIG ACL
resource "aws_s3_bucket_acl" "b-acl" {
    bucket = aws_s3_bucket.b.id
    acl    = "public-read"
}

# S3 BUCKET CONFIG VERSIONING
resource "aws_s3_bucket_versioning" "b-versioning" {
    bucket = aws_s3_bucket.b.id
    versioning_configuration {
        status = "Enabled"
    }
}

# S3 BUCKET CONFIG STATIC WEBSITE
resource "aws_s3_bucket_website_configuration" "b-website" {
    bucket = aws_s3_bucket.b.bucket
    index_document {
        suffix = "index.html"
    }
    error_document {
        key = "error.html"
    }
}

# S3 BUCKET OBJECTS
resource "aws_s3_bucket_object" "b-objects" {
    bucket   = aws_s3_bucket.b.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    acl      = "public-read"
}