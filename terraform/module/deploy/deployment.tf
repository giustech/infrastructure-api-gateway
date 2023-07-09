resource "aws_api_gateway_deployment" "default" {
  rest_api_id = var.rest_api_id
}

resource "aws_api_gateway_stage" "default" {
  depends_on = [aws_api_gateway_deployment.default]
  deployment_id = aws_api_gateway_deployment.default.id
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage
}

resource "aws_api_gateway_domain_name" "default" {
  domain_name = var.domain
  regional_certificate_arn = var.certificate_arn
  tags = {
    Name = var.api_name
    Provider = "terraform"
  }
  endpoint_configuration {
    types = [ "REGIONAL" ]
  }
}


resource "aws_api_gateway_base_path_mapping" "default" {
  depends_on = [
    aws_api_gateway_deployment.default,
    aws_api_gateway_stage.default,
    aws_api_gateway_domain_name.default
  ]
  api_id      = var.rest_api_id
  domain_name = var.domain
  stage_name = var.stage
}


