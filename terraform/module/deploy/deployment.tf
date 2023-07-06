resource "aws_api_gateway_deployment" "default" {
  rest_api_id = var.rest_api_id
}

resource "aws_api_gateway_stage" "default" {
  depends_on = [aws_api_gateway_deployment.default]
  deployment_id = aws_api_gateway_deployment.default.id
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage
}

resource "aws_api_gateway_base_path_mapping" "default" {
  depends_on = [aws_api_gateway_deployment.default, aws_api_gateway_stage.default]
  api_id      = var.rest_api_id
  domain_name = var.domain
  stage_name = var.stage
}


