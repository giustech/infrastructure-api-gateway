variable "endpoint_dns" {
  type = string
}

variable "api_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "certificate_arn" {
  type = string
}

variable "security_groups_id" {
  type = list(string)
}

variable "region" {
  type = string
}
variable "vpc_ips" {
  type = list(string)
}
