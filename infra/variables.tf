variable "prefix" {
  description = "Org shortcode used in resource names (e.g. 'proops')"
  type        = string
}

variable "project" {
  description = "Project shortcode (e.g. 'taskmanager')"
  type        = string
}

variable "service" {
  description = "Service this stack belongs to; also the ECR repository's second name segment"
  type        = string
}

variable "environment" {
  description = "ECR repo and CI role are built once and shared by every environment, so this is 'shared'"
  type        = string
  default     = "shared"
}

variable "region" {
  description = "Full AWS region name"
  type        = string
}

variable "region_code" {
  description = "Compact region code (e.g. 'apse1')"
  type        = string
}

variable "github_subject_prefix" {
  description = <<-EOT
    Prefix of this repo's GitHub OIDC `sub` claim. The repo uses immutable subjects, so it carries
    the numeric owner and repo IDs, e.g. repo:<org>@<org-id>/<repo>@<repo-id>. Read it from:
      gh api repos/<org>/<repo>/actions/oidc/customization/sub --jq .sub_claim_prefix
    A trust policy written with plain names never matches and AWS answers AccessDenied.
  EOT
  type        = string
}

variable "ci_branch" {
  description = "Branch whose workflow runs may push images"
  type        = string
  default     = "main"
}

variable "tfstate_bucket" {
  description = "Remote state bucket, read to find the shared GitHub OIDC provider"
  type        = string
}

variable "responsible_party" {
  description = "Contact for the resources (tag)"
  type        = string
}

variable "owner" {
  description = "Owner of the resources (tag)"
  type        = string
}

variable "deploy_environments" {
  description = "GitHub Environments whose deploy jobs may pull images from ECR"
  type        = list(string)
  default     = ["dev", "staging", "prod"]
}
