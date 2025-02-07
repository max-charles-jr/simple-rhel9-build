# EventBridge Rule
resource "aws_cloudwatch_event_rule" "stop_ec2_rule" {
  name                = "stop_ec2_instance_rule"
  description         = "Rule to stop EC2 instance at a specific time"
  schedule_expression = "cron(0 22 * * ? *)" # Replace with your desired schedule (e.g., 10 PM UTC)
}

# EventBridge Target
resource "aws_cloudwatch_event_target" "stop_ec2_target" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_rule.name
  target_id = "StopEC2Instance"
  arn       = aws_lambda_function.stop_ec2_lambda.arn
}
