
resource "aws_iam_policy" "s3_operation_bucket_policy" {
  name        = var.iam_s3_bucket_policy
  path        = "/"
  description = "Allow bucket to get objects"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "allow_read_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
            "s3:GetObject",
            "s3:ListBucket",
            "s3:PutObject",
            "s3:DeleteObject"
         ],
            "Resource": [
               "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}", 
               "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3-bucket
  acl    = "private"

  force_destroy = true

  tags = {
    Name = var.s3-bucket
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_version" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.bucket-versioning
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls   = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls  = var.ignore_public_acls
}
