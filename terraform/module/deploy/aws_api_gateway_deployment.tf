resource "aws_api_gateway_deployment" "default" {
  rest_api_id = var.rest_api_id
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage

  depends_on    = [
    aws_cloudwatch_log_group.api_gateway_logs,
    aws_api_gateway_account.default
  ]

  lifecycle {
    create_before_destroy = true
  }
}

