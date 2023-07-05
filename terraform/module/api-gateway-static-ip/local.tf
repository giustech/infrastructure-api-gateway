locals {
  subnet_status = {

    private = {
      vpc_id = data.aws_vpc.default.id
      status = "private"
    }

    public = {
      vpc_id = data.aws_vpc.default.id
      status = "public"
    }

  }
}