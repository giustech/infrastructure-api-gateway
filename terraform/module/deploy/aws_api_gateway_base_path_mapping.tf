
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
