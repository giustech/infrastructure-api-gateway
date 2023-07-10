resource "aws_api_gateway_stage" "default" {
  depends_on = [aws_api_gateway_deployment.default]
  deployment_id = aws_api_gateway_deployment.default.id
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage
#  access_log_settings {
#    destination_arn = aws_cloudwatch_log_group.default.arn
#    format          = <<EOF
#      { "requestId":"$context.requestId", \
#        "extendedRequestId":"$context.extendedRequestId", \
#        "ip": "$context.identity.sourceIp", \
#        "caller":"$context.identity.caller", \
#        "user":"$context.identity.user", \
#        "requestTime":"$context.requestTime", \
#        "httpMethod":"$context.httpMethod", \
#        "resourcePath":"$context.resourcePath", \
#        "status":"$context.status", \
#        "protocol":"$context.protocol", \
#        "responseLength":"$context.responseLength" \
#      }
#EOF
#  }
}

resource "aws_api_gateway_method_settings" "general_settings" {
  rest_api_id = var.rest_api_id
  stage_name  = var.stage
  method_path = "*/*"

  settings {
    # Enable CloudWatch logging and metrics
    metrics_enabled        = true
    data_trace_enabled     = true
    logging_level          = "INFO"

    # Limit the rate of calls to prevent abuse and unwanted charges
    throttling_rate_limit  = 100
    throttling_burst_limit = 50
  }
}


resource "aws_api_gateway_account" "default" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cloudwatch" {
  name               = "tf-${var.api_name}-cloudwatch"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = ["*"]
  }
}
resource "aws_iam_role_policy" "cloudwatch" {
  name   = "tf-${var.api_name}-cloudwatch"
  role   = aws_iam_role.cloudwatch.id
  policy = data.aws_iam_policy_document.cloudwatch.json
}