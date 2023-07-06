module "api-gateway" {
  source = "./module/api-gateway-static-ip"
  account_number = var.account_number
  api_name = var.api_name
  region = var.region
  vpc_name = var.vpc_name
}

module "example-resource" {
  depends_on                  = [module.api-gateway]
  source                      = "./module/api-gateway-resources"
  rest_api_id                 = module.api-gateway.rest_api_id
  parent_id                   = module.api-gateway.rest_api_root_resource_id
  path                        = "test"
#  uri                         = "http://${var.account-service-col-loadbalancer}/"
#  methods                     = [
#    module.account-service-col-methods.default_method_get,
#    module.account-service-col-methods.default_method_option,
#  ]
}