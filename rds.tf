resource "aws_db_instance" "wordpress_db_mysql_cloudzenia" {
    identifier="wordpress-mysql-db-cloudzenia"
    engine="mysql"
    engine_version=var.engine_version_mysql
    instance_class=var.db_instance_class
    allocated_storage=var.db_storage
    storage_type=var.db_storage_type
    db_name=var.db_name
    username=var.db_username
    password=var.db_password
    db_subnet_group_name=aws_db_subnet_group.rds_subnet_group_cloudzenia.name
    vpc_security_group_ids=[aws_security_group.rds_sg_cloudzenia.id]
    publicly_accessible=false
    skip_final_snapshot=true
    multi_az=false
    backup_retention_period = 1
    backup_window = "03:00-04:00"


    tags={
        Name="wordpress_db_mysql_cloudzenia"
    }
}