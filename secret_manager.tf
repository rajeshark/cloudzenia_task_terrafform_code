resource "aws_secretsmanager_secret" "rds_secrets_db" {
    name="worpress-rds-credentials-cloudnia-6"
    tags={
        Name="wordpress-rds-credentials-cloudzenia-6"
    }
}
resource "aws_secretsmanager_secret_version" "rds_secrets_value" {
    secret_id = aws_secretsmanager_secret.rds_secrets_db.id
    secret_string = jsonencode({
        username=var.db_username
        password=var.db_password
    })
}