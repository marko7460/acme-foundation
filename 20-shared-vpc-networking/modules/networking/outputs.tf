output "vpc" {
  description = "Shared VPCs information"
  value       = module.vpc
}

output "vpc_service_perimeter" {
  description = "VPC Service Permiter"
  value       = module.regular_service_perimeter
}