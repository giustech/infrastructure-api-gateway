locals {

  methods = flatten([
    for k, v in var.methods : [
      for index in v["method"]["verbs"] : merge(v, {verb = index})
    ]
  ])

  index_integrations = flatten([
    for key, method in local.methods : key if method["integration_response"] != null && method["integration_response"]["integration_response_status_code"] != null && method["integration_response"]["integration_response_status_code"]  != ""
  ])

}


resource "null_resource" "validation" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    environment = {
      GET = length(flatten([ for index in concat(local.methods) : index if index["verb"] == "GET" ]))
      POST = length(flatten([ for index in concat(local.methods) : index if index["verb"] == "POST" ]))
      PATCH = length(flatten([ for index in concat(local.methods) : index if index["verb"] == "PATCH" ]))
      PUT = length(flatten([ for index in concat(local.methods) : index if index["verb"] == "PUT" ]))
      DELETE = length(flatten([ for index in concat(local.methods) : index if index["verb"] == "DELETE" ]))
      OPTION = length(flatten([ for index in concat(local.methods) : index if index["verb"] == "OPTION" ]))
    }
    command = "sh ${path.module}/validate-methods-size.sh"
    on_failure  = fail
  }

}