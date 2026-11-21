output "ecr_repository_url" {
  description = "Registry URL CI pushes to"
  value       = module.ecr.repository_url
}

output "ci_role_arn" {
  description = "Set as role-to-assume in aws-actions/configure-aws-credentials"
  value       = module.ci_role.arn
}

output "deploy_role_arn" {
  description = "Set as role-to-assume in deploy jobs that pull the image"
  value       = module.deploy_role.arn
}
