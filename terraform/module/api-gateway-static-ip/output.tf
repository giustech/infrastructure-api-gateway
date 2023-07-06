output "vpc" {
  value = data.aws_vpc.default.id
}

output "subnets" {
  value = {
    private = data.aws_subnets.subnets["private"].ids
    public = data.aws_subnets.subnets["public"].ids
  }
}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.default.id
}

output "rest_api_root_resource_id" {
  value = aws_api_gateway_rest_api.default.root_resource_id
}
