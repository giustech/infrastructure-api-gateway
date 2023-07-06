resource "aws_globalaccelerator_accelerator" "default" {
  name            = "tf-${var.api_name}-global-accelerator"
  ip_address_type = "IPV4"
  enabled         = true
  tags = {
    Name = "tf-${var.api_name}-api-gateway"
    Provider = "terraform"
    Environment = var.api_name
  }
}

resource "aws_globalaccelerator_listener" "default" {
  depends_on = [aws_globalaccelerator_accelerator.default]
  accelerator_arn = aws_globalaccelerator_accelerator.default.id
  protocol        = "TCP"
  port_range {
    from_port = 80
    to_port   = 80
  }
  port_range {
    from_port = 443
    to_port   = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "default" {
  depends_on = [aws_lb.default, aws_globalaccelerator_listener.default]
  listener_arn = aws_globalaccelerator_listener.default.id
  endpoint_group_region = var.region
  threshold_count = 3
  traffic_dial_percentage = 100
  health_check_interval_seconds = 30
  health_check_port = 80
  health_check_protocol = "TCP"
  endpoint_configuration {
    endpoint_id = aws_lb.default.arn
    weight = 100
    client_ip_preservation_enabled = true
  }
}


output "dns_global_accelerator" {
  value = aws_globalaccelerator_accelerator.default.dns_name
}