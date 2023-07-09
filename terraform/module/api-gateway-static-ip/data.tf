#data "dns_a_record_set" "endpoint_1" {
#  host = aws_vpc_endpoint.default.dns_entry[1].dns_name
#}
#
#data "dns_a_record_set" "endpoint_2" {
#  host = aws_vpc_endpoint.default.dns_entry[2].dns_name
#}

data "dns_a_record_set" "endpoint" {
  host = aws_vpc_endpoint.default.dns_entry[0].dns_name
}

