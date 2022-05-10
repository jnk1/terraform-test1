# S3プライベートバケット
resource "aws_s3_bucket" "private" {
  bucket = "private-pragmatic-terraform-20220510"

  # バージョニング
  versioning {
    enabled = true
  }

  # 暗号化
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# ブロックパブリックアクセス
# 予期しないオブジェクトの公開を抑止できる。
# 特別に理由がなければ全て有効にする。
resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3パブリックバケット
resource "aws_s3_bucket" "public" {
  bucket = "public-pragmatic-terraform-20220510"
  acl    = "public-read"

  cors_rule {
    allowed_origins = ["https://example.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}
