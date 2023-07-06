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