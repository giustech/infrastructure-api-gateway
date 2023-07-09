variable "parent_id" {
  type = string
}

variable "path" {
  type = string
}

variable "rest_api_id" {
  type = string
}

variable "authorization" {
  default = "NONE"
  type = string

}
variable "request_method_api_key_required" {
  type = bool
  default = false
}

variable "authorizer_id" {
  default = ""
  type = string
}

variable "methods" {
  type = list(object({
    method = object({
      verbs = list(string)
      authorization = string
      authorizer_id = string
      request_method_api_key_required = bool
    })
    integration = object({
      uri = string
      type = string
      request_parameters = map(string)
    })
    integration_response = object({
      integration_response_status_code = string
      response_templates = map(string)
    })
    method_response = object({
      status_code = string
      response_models = map(string)
    })
  }))
  default = []
}