output "alb_dns_name_task1" {
    value=aws_lb.cloudzenia_alb.dns_name
  
}
output "alb_dns_name_task2" {
    value = aws_lb.alb_ec2.dns_name
  
}
output "rds_enpoint" {
    value = aws_db_instance.wordpress_db_mysql_cloudzenia.endpoint
  
}
output "wordpress_url" {
  value = "https://wordpress.appquickcartsite.in"
}
output "microservice_url" {
  value = "https://microservice.appquickcartsite.in"
}
output "cloudfront_url" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
output "static_site_url" {
  value = "https://static-s3.appquickcartsite.in"
}

output "ec2_instance1_url" {
  value = "https://ec2-instance1.appquickcartsite.in"
}

output "ec2_docker1_url" {
  value = "https://ec2-docker1.appquickcartsite.in"
}

output "ec2_instance2_url" {
  value = "https://ec2-instance2.appquickcartsite.in"
}

output "ec2_docker2_url" {
  value = "https://ec2-docker2.appquickcartsite.in"
}

output "alb_instance_url" {
  value = "https://ec2-alb-instance.appquickcartsite.in"
}

output "alb_docker_url" {
  value = "https://ec2-alb-docker.appquickcartsite.in"
}