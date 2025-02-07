# Lambda Function
resource "aws_lambda_function" "stop_ec2_lambda" {
  filename      = "lambda_function_payload.zip" # Replace with your Lambda deployment package
  function_name = "stop_ec2_instance"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  environment {
    variables = {
      INSTANCE_ID = "your-instance-id" # Replace with your EC2 instance ID
    }
  }
}

# Lambda Permission for EventBridge
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_ec2_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_ec2_rule.arn
}
