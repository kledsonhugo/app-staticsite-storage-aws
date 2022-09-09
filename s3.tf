# VARS

variable "bucket_name" {
    default = "static-site-kledson-basso-lalala"
}

variable "website_endpoint" {
    default = "true"
}


# S3 BUCKET

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    website {
        index_document = "index.html"
        error_document = "error.html"
    }
}

resource "aws_s3_bucket_versioning" "bucket-versioning" {
    bucket = aws_s3_bucket.bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "public-read"
}

output "aws_s3_bucket_website_endpoint" {
    value = "${var.website_endpoint =="true"? aws_s3_bucket.bucket.website_endpoint : ""}"
}


# S3 BUCKET OBJECTS

resource "aws_s3_bucket_object" "bucket-objects" {
    bucket       = aws_s3_bucket.bucket.id
    for_each     = fileset("data/", "*")
    key          = each.value
    source       = "data/${each.value}"
    acl          = "public-read"
    content_type = "text/html"
    etag         = "${md5(file("data/${each.value}"))}"
}
