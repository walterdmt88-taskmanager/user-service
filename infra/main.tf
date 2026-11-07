locals {
  # Layer 1 — common tags passed to every module
  tags = {
    Project          = var.project
    Environment      = var.environment
    ResponsibleParty = var.responsible_party
    Owner            = var.owner
  }
}

# The account-wide GitHub OIDC provider is owned by platform-infra, not by this service.
data "terraform_remote_state" "github_oidc" {
  backend = "s3"

  config = {
    bucket = var.tfstate_bucket
    key    = "platform-infra/github-oidc.tfstate"
    region = var.region
  }
}

module "ecr" {
  source = "git::https://github.com/walterdmt88-taskmanager/terraform-modules.git//modules/aws_ecr?ref=v2.0.0"

  prefix      = var.prefix
  project     = var.project
  environment = var.environment
  region_code = var.region_code
  region      = var.region
  tags        = local.tags

  purpose = var.service
}

# What the CI role may do: push images to THIS service's repository and nothing else.
data "aws_iam_policy_document" "ecr_push" {
  # GetAuthorizationToken does not support resource-level permissions.
  statement {
    sid       = "EcrLogin"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid = "PushToServiceRepository"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:DescribeImages", # lets CI check whether a tag already exists before pushing
    ]
    resources = [module.ecr.arn]
  }
}

module "ci_role" {
  source = "git::https://github.com/walterdmt88-taskmanager/terraform-modules.git//modules/aws_iam_github_role?ref=v2.0.0"

  prefix      = var.prefix
  project     = var.project
  environment = var.environment
  region_code = var.region_code
  region      = var.region
  tags        = local.tags

  purpose           = "${var.service}-ci"
  oidc_provider_arn = data.terraform_remote_state.github_oidc.outputs.provider_arn
  allowed_subjects  = ["repo:${var.github_repository}:ref:refs/heads/${var.ci_branch}"]
  policy_json       = data.aws_iam_policy_document.ecr_push.json
}
