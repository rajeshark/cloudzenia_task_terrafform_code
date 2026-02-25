data "aws_route53_zone" "main" {
    name = var.domain_name
    private_zone = false
  
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}
resource "aws_route53_record" "cloudfront_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront_cert.domain_validation_options :
    dvo.domain_name => dvo
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}


resource "aws_route53_record" "ec2_instance1_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name="ec2-instance1.${var.domain_name}"
  type="A"
  ttl=300
  records = [aws_eip.eip_1.public_ip]
  
}
resource "aws_route53_record" "ec2_docker1_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name="ec2-docker1.${var.domain_name}"
  type="A"
  ttl=300
  records = [aws_eip.eip_1.public_ip]
  
}
resource "aws_route53_record" "ec2_instance2_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name="ec2-instance2.${var.domain_name}"
  type="A"
  ttl=300
  records = [aws_eip.eip_2.public_ip]
  
}
resource "aws_route53_record" "ec2_docker2_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name="ec2-docker2.${var.domain_name}"
  type="A"
  ttl=300
  records = [aws_eip.eip_2.public_ip]
  
}
resource "aws_route53_record" "alb_instance_dns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "ec2-alb-instance.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb_ec2.dns_name
    zone_id                = aws_lb.alb_ec2.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "alb_docker_dns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "ec2-alb-docker.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb_ec2.dns_name
    zone_id                = aws_lb.alb_ec2.zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "static" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "static-s3.appquickcartsite.in"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "wordpress_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "wordpress.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.cloudzenia_alb.dns_name
    zone_id                = aws_lb.cloudzenia_alb.zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "micro_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "microservice.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.cloudzenia_alb.dns_name
    zone_id                = aws_lb.cloudzenia_alb.zone_id
    evaluate_target_health = true
  }
}
