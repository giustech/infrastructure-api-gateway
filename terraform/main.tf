variable "domain" {
  type = string
  default = "devops.orbitspot.com"
}

variable "certificate" {
  type = string
  default = "d5251a89-c352-4a02-b705-cdccabfe031f"
}


module "api-gateway" {
  source = "./module/api-gateway-static-ip"
  account_number  = var.account_number
  api_name        = var.api_name
  region          = var.region
  vpc_name        = var.vpc_name
  certificate_arn = "arn:aws:acm:${var.region}:${var.account_number}:certificate/${var.certificate}"
  domain          = var.domain
}
#
#resource "aws_api_gateway_resource" "versionament" {
#  parent_id   = module.api-gateway.rest_api_root_resource_id
#  path_part   = "versionaments"
#  rest_api_id = module.api-gateway.rest_api_id
#}
#
#module "versionament_mock" {
#  source = "./module/resource"
#  http_method = "OPTIONS"
#  parent_id = module.api-gateway.rest_api_root_resource_id
#  path = "versionaments"
#  resource_id = aws_api_gateway_resource.versionament.id
#  rest_api_id = module.api-gateway.rest_api_id
#  integration = {
#    uri = ""
#    type = "MOCK"
#    request_parameters = {}
#    request_templates = {}
#  }
#  integration_response = {
#    integration_response_status_code = "200"
#    response_templates = {}
#    response_parameters = {}
#  }
#  method = {
#    authorization = "NONE"
#    authorizer_id = ""
#    request_method_api_key_required = false
#  }
#  method_response = {
#    status_code = "201"
#    response_models = {}
#    response_parameters = {}
#  }
#}

module "loadbalancer" {
  source              = "./module/loadbalancer"
  endpoint_dns        = module.api-gateway.endpoint_dns_list[0].dns_name
  depends_on          = [module.api-gateway, module.api-gateway.endpoint_dns_list]
  api_name            = var.api_name
  subnet_ids          = module.api-gateway.public_subnet_ids
  vpc_id              = module.api-gateway.vpc_id
  certificate_arn     = "arn:aws:acm:${var.region}:${var.account_number}:certificate/${var.certificate}"
  security_groups_id  = [module.api-gateway.security_group_loadbalancer]
  region              = var.region
  vpc_ips             = module.api-gateway.endpoints_ips
}


module "deploy" {
  depends_on = [module.api-gateway, module.loadbalancer]
  source          = "./module/deploy"
  rest_api_id     = module.api-gateway.rest_api_id
  domain          = var.domain
  create_mapping  = true
  api_name        = var.api_name
  certificate_arn = "arn:aws:acm:${var.region}:${var.account_number}:certificate/${var.certificate}"
}



output "api-gateway" {
  value = {
    dns_global_accelerator = module.loadbalancer.dns_global_accelerator
    roles = {
      cloudwatch = module.deploy.role-cloudwatch
    }
  }
}

output "root_id" {
  value = module.api-gateway.rest_api_root_resource_id
}

output "rest_api_id" {
  value = module.api-gateway.rest_api_id
}

