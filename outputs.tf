output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.compute.alb_dns_name
}

output "db_endpoint" {
  description = "Database endpoint"
  value       = module.database.db_endpoint
}
