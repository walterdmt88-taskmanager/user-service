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

variable "github_repository" {
  description = "GitHub <org>/<repo> allowed to assume the CI role"
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
