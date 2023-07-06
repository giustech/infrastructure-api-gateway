module "api-gateway" {
  source = "./module/api-gateway-static-ip"
  account_number = var.account_number
  api_name = var.api_name
  region = var.region
  vpc_name = var.vpc_name
}

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
  source        = "./module/deploy"
  rest_api_id   = module.api-gateway.rest_api_id
  domain        = var.domain
  body_rest_api = module.api-gateway.body

}

variable "domain" {
  type = string
}

variable "certificate" {
  type = string
}