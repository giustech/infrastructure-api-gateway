resource "aws_vpc_endpoint" "default" {
  depends_on            = [
    aws_security_group.default
  ]
  service_name          = "com.amazonaws.${var.region}.execute-api"
  vpc_id                = data.aws_vpc.default.id
  subnet_ids            = data.aws_subnets.subnets["public"].ids
  vpc_endpoint_type     = "Interface"
  security_group_ids    = [aws_security_group.default.id]
  tags                  = {
    Name                = "endpoint-${var.api_name}"
    Provider            = "terraform"
  }
  policy = <<EOF
{
	"Statement": [
		{
			"Principal": "*",
			"Action": [
				"execute-api:Invoke"
			],
			"Effect": "Allow",
			"Resource": [
				"arn:aws:execute-api:${var.region}:${var.account_number}:*/*/*/*"
			]
		}
	]
}
EOF
}