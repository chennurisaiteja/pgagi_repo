# ------------------------------
# 1. SNS Topic to send email alerts
# ------------------------------
resource "aws_sns_topic" "alert_topic" {
  name = "${var.project_name}-alerts"
}

# Subscribe your email address to the SNS topic
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = "awschsaiteja@gmail.com"  # 🔁 REPLACED with your actual email
}

# ------------------------------
# 2. CloudWatch Alarm for ECS Backend CPU > 70%
# ------------------------------
resource "aws_cloudwatch_metric_alarm" "backend_high_cpu" {
  alarm_name          = "${var.project_name}-backend-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300  # 5 minutes
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Triggered when ECS backend CPU > 70% for 5 minutes"
  alarm_actions       = [aws_sns_topic.alert_topic.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.backend.name
  }

  depends_on = [aws_ecs_service.backend]
}


