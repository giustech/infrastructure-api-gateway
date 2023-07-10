output "resource_id" {
  value = aws_api_gateway_resource.resource.id
}

output "aws_api_gateway_resource"  {
  value = aws_api_gateway_resource.resource
}

output "aws_api_gateway_method" {
  value = aws_api_gateway_method.methods
}

output "aws_api_gateway_integration" {
  value = aws_api_gateway_integration.integrations
}

output "aws_api_gateway_integration_response" {
  value = aws_api_gateway_integration_response.integrations_response
}

output "aws_api_gateway_method_response" {
  value = aws_api_gateway_method_response.methods_response
}
