resource "aws_api_gateway_rest_api" "default" {
  name = var.api_name
  depends_on = [
    aws_vpc_endpoint.default
  ]
  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = [
      aws_vpc_endpoint.default.id
    ]
  }

  tags = {
    Name = var.api_name
    Provider = "terraform"
  }

}

resource "aws_api_gateway_rest_api_policy" "default" {
  depends_on = [aws_api_gateway_rest_api.default, aws_security_group.default]
  rest_api_id = aws_api_gateway_rest_api.default.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "arn:aws:execute-api:us-east-1:931670397156:*"
        },
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "arn:aws:execute-api:us-east-1:931670397156:*",
            "Condition": {
                "StringNotEquals": {
                    "aws:SourceVpce": "${aws_vpc_endpoint.default.id}"
                }
            }
        }
    ]
}
EOF
}