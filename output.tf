output "parent_zone_names" {
  description = "The names of the parent Route 53 hosted zones"
  value       = [for k, v in aws_route53_zone.parent_zone : v.name]
}

output "parent_zone_ids" {
  description = "The IDs of the parent Route 53 hosted zones"
  value       = [for k, v in aws_route53_zone.parent_zone : v.zone_id]
}

output "child_zone_names" {
  description = "The names of the child Route 53 hosted zones"
  value       = [for k, v in aws_route53_zone.child_zone : v.name]
}

output "child_zone_ids" {
  description = "The IDs of the child Route 53 hosted zones"
  value       = [for k, v in aws_route53_zone.child_zone : v.zone_id]
}

output "private_zone_names" {
  description = "The names of the private Route 53 hosted zones"
  value       = [for k, v in aws_route53_zone.private_zone : v.name]
}

output "private_zone_ids" {
  description = "The IDs of the private Route 53 hosted zones"
  value       = [for k, v in aws_route53_zone.private_zone : v.zone_id]
}

output "child_zone_name_servers" {
  description = "The name servers of the child Route 53 hosted zones"
  value       = { for k, v in data.aws_route53_zone.child_zone_ns : k => v.name_servers }
}

output "child_ns_record_names" {
  description = "The names of the child NS records"
  value       = [for k, v in aws_route53_record.child_ns_records : v.name]
}

output "child_ns_record_zone_ids" {
  description = "The zone IDs of the child NS records"
  value       = [for k, v in aws_route53_record.child_ns_records : v.zone_id]
}
