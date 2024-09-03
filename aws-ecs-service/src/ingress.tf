locals {
  // Flatten the list of ingresses in the ECS service config
  container_ingress = flatten([
    for port in var.ports :
    port != null && lookup(port, "ingresses", null) != null ? [
      for ingress in lookup(port, "ingresses", []) : {
        container_name = "main"
        container_port = port
        hostname       = ingress.hostname
        path           = ingress.path
        create_dns     = ingress.create_dns
        # strip the first subdomain block so we are left with just the domain
        domain = trimprefix(ingress.hostname, "${element(split(".", ingress.hostname), 0)}.")
      }
    ] : []
  ])

  // Create a map with the unique pairings of container and port. This is needed for creating and associating target groups
  container_ingress_port_map = { for ingress in local.container_ingress :
    "${ingress.container_name}-${ingress.container_port}" => {
      container_name = ingress.container_name
      container_port = ingress.container_port
      domain         = ingress.domain
    }
  }

  // Create a map of hostname => container_ingress if the create_dns bool is true for creating DNS records
  dns_records = { for ingress in local.container_ingress :
    ingress.hostname => ingress if ingress.create_dns == true
  }

  // Flatten the ALB listeners into a list of objects for each variation of ingress, listener and domain to make it more easily searchable
  cluster_listeners = flatten([
    for ingress in var.ecs_cluster.data.capabilities.ingress : [
      for listener in ingress.listeners : [
        for domain in listener.domains : {
          load_balancer_arn  = ingress.load_balancer_arn
          security_group_arn = ingress.security_group_arn
          listener_arn       = listener.arn
          port               = listener.port
          protocol           = listener.protocol
          domain             = domain
        }
      ]
    ]
  ])

  // The ECS service needs to key off of the ECS ingress (ALB) domains. Iterate through the list of cluster listeners and create
  // a map of domain -> HTTPS listener that matches HTTPS port and protocol
  domain_to_https_cluster_listener_map = {
    for listener in local.cluster_listeners : listener.domain => listener if listener.port == 443 && listener.protocol == "https"
  }
}

resource "aws_lb_target_group" "main" {
  for_each = local.container_ingress_port_map
  // Maximum length is 32 characters. Append the port and take the last 32 chars
  name        = trimprefix(substr("${var.md_metadata.name_prefix}-${each.value.container_port}", -32, -1), "-")
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener_rule" "main" {
  for_each     = { for ingress in local.container_ingress : "${ingress.hostname}${ingress.path}" => ingress }
  listener_arn = local.domain_to_https_cluster_listener_map[each.value.domain].listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main["${each.value.container_name}-${each.value.container_port}"].arn
  }

  condition {
    path_pattern {
      values = [each.value.path]
    }
  }

  condition {
    host_header {
      values = [each.value.hostname]
    }
  }
}

data "aws_route53_zone" "lookup" {
  for_each = local.dns_records
  name     = "${each.value.domain}."
}

data "aws_lb" "lookup" {
  for_each = local.dns_records
  arn      = local.domain_to_https_cluster_listener_map[each.value.domain].load_balancer_arn
}

resource "aws_route53_record" "main" {
  for_each = local.dns_records
  zone_id  = data.aws_route53_zone.lookup[each.key].zone_id
  name     = each.key
  type     = "CNAME"
  ttl      = 300
  records  = [data.aws_lb.lookup[each.key].dns_name]
}
