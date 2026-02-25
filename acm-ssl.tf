resource "aws_acm_certificate" "ssl_certificate" {
  
  domain_name = "appquickcartsite.in"
  validation_method = "DNS"

  subject_alternative_names = ["wordpress.${var.domain_name}","microservice.${var.domain_name}","ec2-alb-docker.${var.domain_name}","ec2-alb-instance.${var.domain_name}"]
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_acm_certificate_validation" "ssl_validation" {
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}

resource "aws_acm_certificate" "cloudfront_cert" {
  provider          = aws.virginia
  domain_name       = "static-s3.${var.domain_name}"
  validation_method = "DNS"
}
resource "aws_acm_certificate_validation" "cloudfront_ssl_validation" {
  provider = aws.virginia

  certificate_arn = aws_acm_certificate.cloudfront_cert.arn

  validation_record_fqdns = [
    for record in aws_route53_record.cloudfront_validation :
    record.fqdn
  ]
}