variable "parent_id" {
  type = string
}

variable "path" {
  type = string
}

variable "rest_api_id" {
  type = string
}

variable "http_method" {
  type = string
}

variable "method" {
  type = object({
    authorization = string
    authorizer_id = string
    request_method_api_key_required = bool
  })
}
variable "integration" {
  type = object({
    uri = string
    type = string
    request_parameters = map(string)
    request_templates = map(string)
  })
}
variable "integration_response" {
  type = object({
    integration_response_status_code = string
    response_templates = map(string)
    response_parameters = map(string)
  })
}
variable "method_response" {
  type = object({
    status_code = string
    response_models = map(string)
    response_parameters = map(string)
  })
}

variable "resource_id" {
  type = string
}