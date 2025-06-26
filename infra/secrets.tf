# Generate a static timestamp once per terraform state
resource "time_static" "now" {}

resource "aws_secretsmanager_secret" "db_credentials" {
  name = "${var.project_name}-db-credentials-${replace(time_static.now.rfc3339, ":", "-")}"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "admin",
    password = "mypassword",
    host     = "db.example.com"
  })
}


