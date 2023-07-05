resource "aws_security_group" "default" {
  name = "global-acelerator-${var.api_name}"
  description = "GlobalAcelerator Api Gateway"
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = var.api_name
    Provider = "terraform"
  }
}
