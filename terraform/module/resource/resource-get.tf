













#resource "aws_api_gateway_integration_response" "get_integration_response" {
#  count                     = length(local.GET_INTEGRATION_RESPONSE_INDEX) > 0 ? length(local.GET_INTEGRATION_RESPONSE_INDEX): 0
#  depends_on                = [ aws_api_gateway_integration.get_integration ]
#  http_method               = aws_api_gateway_method.aws_api_gateway_resource_get[local.GET_INTEGRATION_RESPONSE_INDEX[count.index]].http_method
#  resource_id               = aws_api_gateway_resource.resource.id
#  rest_api_id               = var.rest_api_id
#  status_code               = local.GET_METHODS[local.GET_INTEGRATION_RESPONSE_INDEX[count.index]]["data"]["integration_response_status_code"]
#  response_templates        = contains(keys(local.GET_METHODS[local.GET_INTEGRATION_RESPONSE_INDEX[count.index]]["data_objects"]), "integration_response_response_templates") ? local.GET_METHODS[local.GET_INTEGRATION_RESPONSE_INDEX[count.index]]["data_objects"]["integration_response_response_templates"] : {}
#}
#
#resource "aws_api_gateway_method_response" "get_method_response" {
#  for_each                  = local.GET_METHODS
#  http_method               = aws_api_gateway_method.aws_api_gateway_resource_get[each.key].http_method
#  resource_id               = aws_api_gateway_resource.resource.id
#  rest_api_id               = var.rest_api_id
#  status_code               = each.value["data"]["method_response_status_code"]
#  response_models           = contains(keys(each.value["data_objects"]), "method_response_response_models") ? each.value["data_objects"]["method_response_response_models"] : {}
#}