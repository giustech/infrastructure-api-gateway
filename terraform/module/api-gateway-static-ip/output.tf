output "vpc_id" {
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

output "endpoint_dns_list" {
  value = aws_vpc_endpoint.default.dns_entry
}

output "public_subnet_ids" {
  value = data.aws_subnets.subnets["public"].ids
}

output "security_group_loadbalancer" {
  value = aws_security_group.default.id
}

output "endpoints_ips" {
  value = data.dns_a_record_set.endpoint.addrs
}

output "body" {
  value = aws_api_gateway_rest_api.default.body
}