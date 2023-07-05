module "api-gateway" {
  source = "./module/api-gateway-static-ip"
  account_number = var.account_number
  api_name = var.api_name
  region = var.region
  vpc_name = var.vpc_name
}
