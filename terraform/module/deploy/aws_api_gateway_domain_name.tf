resource "aws_api_gateway_domain_name" "default" {
  domain_name = var.domain
  regional_certificate_arn = var.certificate_arn
  tags = {
    Name = var.api_name
    Provider = "terraform"
  }
  endpoint_configuration {
    types = [ "REGIONAL" ]
  }
}

