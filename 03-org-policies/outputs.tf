output "access_context_manager_policy_ids" {
  description = "Resource names of the AccessPolicies that were created. This is a map of policy_name => policy_id"
  value = {
    (var.policy_name) = module.org_policy.policy_id
  }
}