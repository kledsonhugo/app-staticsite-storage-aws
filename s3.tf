# VARS
variable "bucket_name" {
    default = "static-site-kledson-basso"
}

variable "website" {
    default = "true"
}

# S3 BUCKET
resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"
    acl    = "public-read"
    website {
        index_document = "index.html"
        error_document = "error.html"
    }
    versioning {
        enabled = true
    }
}

output "aws_s3_bucket_website_endpoint" {
    value = "${var.website =="true"? aws_s3_bucket.bucket.website_endpoint : ""}"
}

# S3 BUCKET OBJECTS
resource "aws_s3_bucket_object" "bucket-objects" {
    bucket   = aws_s3_bucket.bucket.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    acl      = "public-read"
    etag     = "${md5(file("data/${each.value}"))}"
}