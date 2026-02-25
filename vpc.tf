resource "aws_vpc" "cloudzenia_vpc" {
    cidr_block=var.vpc_cidr
    enable_dns_hostnames=true
    enable_dns_support=true
    tags={
        Name="cloudznia_vpc"
    }
}


resource "aws_subnet" "public_subnet_1" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    cidr_block=var.public_subnet_1_cidr
    availability_zone=var.az1
    tags={
        Name="public_subnet_1"
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    cidr_block=var.public_subnet_2_cidr
    availability_zone=var.az2
    tags={
        Name="public_subnet_2"
    }
}


resource "aws_subnet" "private_subnet_1" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    cidr_block=var.private_subnet_1_cidr
    availability_zone=var.az1
    tags={
        Name="private_subnet_1"
    }
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    cidr_block=var.private_subnet_2_cidr
    availability_zone=var.az2
    tags={
        Name="private_subnet_2"
    }
}

resource "aws_internet_gateway" "internet_gateway_cloudzenia" {
    vpc_id=aws_vpc.cloudzenia_vpc.id
    tags={
        Name="internet_gateway_cloudzenia"
    }
}
resource "aws_route_table" "public_route_table_cloudzenia" {
    vpc_id = aws_vpc.cloudzenia_vpc.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.internet_gateway_cloudzenia.id
    } 
    tags={
        Name="public_route_table_cloudzenia"
    }
}

resource "aws_eip" "cloudzenia_eip" {
    domain = "vpc"
    tags={
       Name= "cloudzenia-eip"
    }
}

resource "aws_nat_gateway" "nat_gateway_cloudzenia" {
    allocation_id = aws_eip.cloudzenia_eip.id
    subnet_id = aws_subnet.public_subnet_1.id
    depends_on = [aws_internet_gateway.internet_gateway_cloudzenia] 
tags={
    Name="nat_gateway_cloudzenia"
}
}

resource "aws_route_table" "private_route_table_cloudzenia" {
    vpc_id = aws_vpc.cloudzenia_vpc.id
    route{
        cidr_block="0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_cloudzenia.id

    }
    tags={
        Name="private_route_table_cloudzenia"
    }

  
}
resource "aws_route_table_association" "public_subnet_1_association" {
    route_table_id = aws_route_table.public_route_table_cloudzenia.id
    subnet_id = aws_subnet.public_subnet_1.id
  
}
resource "aws_route_table_association" "public_subnet_2_association" {
    route_table_id = aws_route_table.public_route_table_cloudzenia.id
    subnet_id = aws_subnet.public_subnet_2.id
  
}

resource "aws_route_table_association" "private_subnet_1_association" {
    route_table_id = aws_route_table.private_route_table_cloudzenia.id
    subnet_id = aws_subnet.private_subnet_1.id
  
}
resource "aws_route_table_association" "private_subnet_2_association" {
    route_table_id = aws_route_table.private_route_table_cloudzenia.id
    subnet_id = aws_subnet.private_subnet_2.id
  
}





