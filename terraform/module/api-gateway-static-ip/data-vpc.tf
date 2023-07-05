data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "subnets" {
  for_each = local.subnet_status
  filter {
    name   = "tag:VpcId"
    values = [each.value["vpc_id"]]
  }
  filter {
    name   = "tag:Status"
    values = [each.value["status"]]
  }
}
