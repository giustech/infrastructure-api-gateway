resource "aws_api_gateway_resource" "resource" {
  parent_id     = var.parent_id
  path_part     = var.path
  rest_api_id   = var.rest_api_id
}

resource "aws_api_gateway_method" "methods" {
  count             = length(local.methods) > 0 ? length(local.methods) : 0
  depends_on        = [aws_api_gateway_resource.resource]
  authorization     = local.methods[count.index]["method"]["authorization"]
  http_method       = local.methods[count.index]["verb"]
  resource_id       = aws_api_gateway_resource.resource.id
  rest_api_id       = var.rest_api_id
  api_key_required  = local.methods[count.index]["method"]["request_method_api_key_required"]
  authorizer_id     = local.methods[count.index]["method"]["authorizer_id"]
}

resource "aws_api_gateway_integration" "integrations" {
  count                     = length(local.methods) > 0 ? length(local.methods) : 0
  depends_on                = [aws_api_gateway_method.methods]
  http_method               = aws_api_gateway_method.methods[count.index].http_method
  integration_http_method   = aws_api_gateway_method.methods[count.index].http_method
  resource_id               = aws_api_gateway_resource.resource.id
  rest_api_id               = var.rest_api_id
  uri                       = local.methods[count.index]["integration"]["uri"]
  type                      = local.methods[count.index]["integration"]["type"]
  request_parameters        = local.methods[count.index]["integration"]["request_parameters"]
}

resource "aws_api_gateway_integration_response" "integrations_response" {
  count                     = length(local.index_integrations) > 0 ? length(local.index_integrations): 0
  depends_on                = [ aws_api_gateway_integration.integrations ]
  http_method               = aws_api_gateway_method.methods[local.index_integrations[count.index]].http_method
  resource_id               = aws_api_gateway_resource.resource.id
  rest_api_id               = var.rest_api_id
  status_code               = local.methods[local.index_integrations[count.index]]["integration_response"]["integration_response_status_code"]
  response_templates        = local.methods[local.index_integrations[count.index]]["integration_response"]["response_templates"]
}

resource "aws_api_gateway_method_response" "methods_response" {
  count                     = length(local.methods) > 0 ? length(local.methods) : 0
  http_method               = aws_api_gateway_method.methods[count.index].http_method
  resource_id               = aws_api_gateway_resource.resource.id
  rest_api_id               = var.rest_api_id
  status_code               = local.methods[count.index]["method_response"]["status_code"]
  response_models           = local.methods[count.index]["method_response"]["response_models"]
}
