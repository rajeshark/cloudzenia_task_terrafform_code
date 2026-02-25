resource "aws_db_subnet_group" "rds_subnet_group_cloudzenia" {
    subnet_ids=[
        aws_subnet.private_subnet_1.id,
        aws_subnet.private_subnet_2.id
    ]
  tags={
    Name="rds_subnet_group_cloudzenia"

  }
  
}