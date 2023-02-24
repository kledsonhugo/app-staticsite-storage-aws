# RESOURCE: S3 BUCKET (INFRA)

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
    value = "http://${var.website_endpoint =="true"? aws_s3_bucket.bucket.website_endpoint : ""}"
}


# RESOURCE: S3 BUCKET OBJECTS (APPLICATION)

resource "aws_s3_bucket_object" "bucket-objects" {
    bucket       = aws_s3_bucket.bucket.id
    for_each     = fileset("../app/", "*")
    key          = each.value
    source       = "../app/${each.value}"
    acl          = "public-read"
    content_type = "text/html"
    etag         = "${md5(file("../app/${each.value}"))}"
}