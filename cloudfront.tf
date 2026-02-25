resource "aws_cloudfront_distribution" "cdn" {

  origin {
    domain_name = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id   = "s3-origin"

    s3_origin_config {
      origin_access_identity = ""
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  #  geo ristriction BLOCK
  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN"]
    }
  }

aliases = ["static-s3.appquickcartsite.in"]

viewer_certificate {
  acm_certificate_arn = aws_acm_certificate.cloudfront_cert.arn
  ssl_support_method  = "sni-only"
}
}