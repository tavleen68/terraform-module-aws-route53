resource "aws_route53_zone" "parent_zone" {
  for_each = { for k, v in var.parent_zones : k => v if var.create }
  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)
  tags = merge(
    lookup(each.value, "tags", {}),
    var.default_tags
  )
}

resource "aws_route53_zone" "child_zone" {
  for_each = { for k, v in var.child_zones : k => v if var.create }
  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)
  tags = merge(
    lookup(each.value, "tags", {}),
    var.default_tags
  )
}

resource "aws_route53_zone" "private_zone" {
  for_each = { for k, v in var.private_zones : k => v if var.create }
  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)
  dynamic "vpc" {
    for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])
    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(each.value, "tags", {}),
    var.default_tags
  )
}

data "aws_route53_zone" "child_zone_ns" {
  for_each = var.child_zones
  name     = each.key
}

locals {
  parent_zone_id = aws_route53_zone.parent_zone[var.parent_domain].zone_id
}

resource "aws_route53_record" "child_ns_records" {
  for_each = var.child_zones
  zone_id  = local.parent_zone_id
  name     = each.key
  type     = "NS"
  ttl      = 300

  records = data.aws_route53_zone.child_zone_ns[each.key].name_servers
}
