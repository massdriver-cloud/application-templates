resource "aws_security_group" "main" {
  name   = var.md_metadata.name_prefix
  vpc_id = local.vpc_id
}

resource "aws_security_group_rule" "alb_ingress" {
  for_each    = local.container_ingress_port_map
  description = "Allow ALB ingress for container ${each.value.container_name} port ${each.value.container_port}"

  type                     = "ingress"
  from_port                = each.value.container_port
  to_port                  = each.value.container_port
  protocol                 = "tcp"
  source_security_group_id = element(split("/", local.domain_to_https_cluster_listener_map[each.value.domain].security_group_arn), 1)

  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "all_egress" {
  description = "Allow all egress"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.main.id
}
