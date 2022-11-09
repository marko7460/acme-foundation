output "projects" {
  description = "The projects created in the shared folder"
  value       = module.projects
}

output "vpcs" {
  description = "The VPCs created in the shared folder"
  value       = module.vpc
}