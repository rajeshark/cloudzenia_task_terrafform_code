resource "aws_instance" "cloudzenia_ec2_1" {
    ami=var.ami_id
    instance_type=var.ec2_instance_type
    subnet_id=aws_subnet.public_subnet_1.id
    vpc_security_group_ids=[aws_security_group.ec2_security_group.id]
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    associate_public_ip_address=false # for stable public ip we can attch elastic ip which will not change when the ec2 stop and started
    user_data=templatefile("userdata.sh",{
        instance_domain="ec2-instance1.${var.domain_name}",
        docker_domain="ec2-docker1.${var.domain_name}",
        print1="Namaste from Container1",
        print2="Hello from Instance1\n",
        domain="${var.domain_name}"

    })
    

    
    tags={
        Name="cloudzenia-ec2_1"
    }
  
}
resource "aws_instance" "cloudzenia_ec2_2" {
    ami=var.ami_id
    instance_type=var.ec2_instance_type
    subnet_id=aws_subnet.public_subnet_2.id
    vpc_security_group_ids=[aws_security_group.ec2_security_group.id]
    associate_public_ip_address=false # for stable public ip we can attch elastic ip which will not change when the ec2 stop and started
    user_data=templatefile("userdata.sh",{
        instance_domain="ec2-instance2.${var.domain_name}",
        docker_domain="ec2-docker2.${var.domain_name}",
        print1="Namaste from Container2",
        print2="Hello from Instance2\n",
        domain="${var.domain_name}"

    })
    

    
    tags={
        Name="cloudzenia-ec2_2"
    }
  
}
resource "aws_eip" "eip_1" {
    instance=aws_instance.cloudzenia_ec2_1.id
    domain="vpc"
    tags={
        Name="eip-1"
    }
  
}
resource "aws_eip" "eip_2" {
    instance=aws_instance.cloudzenia_ec2_2.id
    domain="vpc"
    tags={
        Name="eip-2"
    }
  
}