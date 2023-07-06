data "dns_a_record_set" "endpoint" {
  host = aws_vpc_endpoint.default.dns_entry[0].dns_name
}
