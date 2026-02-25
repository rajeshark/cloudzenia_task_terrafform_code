resource "aws_security_group" "rds_sg_cloudzenia" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    name="rds_sg_cloudzenia"
ingress {
        from_port=3306
        to_port=3306
        protocol="tcp"
        security_groups=[aws_security_group.ecs_sg_cloudzenia.id]
    }

    egress{
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags={
        Name="rds_sg_cloudzenia"
    }
}
resource "aws_security_group" "alb_sg_wordpress_and_custom_micro" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    name="alb_sg_wordpress_and_custom_microservice"

ingress{
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]  
}
ingress {
        from_port=443
        to_port=443
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"] 
    }
 
    egress{
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks = ["0.0.0.0/0"] 
    }
    tags={
        Name="alb_sg_wordpress_and_custom_microservice"
    }
}

resource "aws_security_group" "ecs_sg_cloudzenia" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    name="ecs-sg-cloudzenia"
ingress{
    from_port=80
    to_port=80
    protocol="tcp"
    security_groups=[aws_security_group.alb_sg_wordpress_and_custom_micro.id]
}
ingress {
        from_port=3000
        to_port=3000
        protocol="tcp"
        security_groups=[aws_security_group.alb_sg_wordpress_and_custom_micro.id]
    }
 
    egress{
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks = ["0.0.0.0/0"] 
    }
    tags={
        Name="ecs-sg-cloudzenia"
    }
  
}
resource "aws_security_group" "ec2_security_group" {
    vpc_id = aws_vpc.cloudzenia_vpc.id
    name="ec2-security-group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # this should be avoid in production there should only be ssh form myip or form paticular subnet
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  egress{
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks = ["0.0.0.0/0"] 
    }
    tags={
        Name="cloudnia-ec2-sg"
    }

}
resource "aws_security_group" "alb_sg_ec2" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    name="alb_sg_ec2"

ingress{
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]  
}
ingress {
        from_port=443
        to_port=443
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"] 
    }
 
    egress{
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks = ["0.0.0.0/0"] 
    }
    tags={
        Name="alb_sg_ec2"
    }
}