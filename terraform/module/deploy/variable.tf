variable "rest_api_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "stage" {
  type = string
  default = "terraform-deploy"
}

variable "create_mapping" {
  type = bool
}

variable "certificate_arn" {
  type = string
}

variable "api_name" {
  type = string
}