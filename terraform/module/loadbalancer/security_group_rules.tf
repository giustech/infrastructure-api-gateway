resource "aws_security_group_rule" "https_ingress" {
  count             = length(var.security_groups_id)
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_groups_id[count.index]
}

resource "aws_security_group_rule" "http_ingress" {
  count             = length(var.security_groups_id)
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_groups_id[count.index]
}

resource "aws_security_group_rule" "all_egress" {
  count             = length(var.security_groups_id)
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_groups_id[count.index]
}
