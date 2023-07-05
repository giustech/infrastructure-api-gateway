output "vpc" {
  value = data.aws_vpc.default.id
}

output "subnets" {
  value = {
    private = data.aws_subnets.subnets["private"].ids
    public = data.aws_subnets.subnets["public"].ids
  }
}

