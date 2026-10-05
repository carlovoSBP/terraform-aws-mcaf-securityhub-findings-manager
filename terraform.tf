terraform {
  # >= 1.12.0, not just the schubergphilis-ep/mcaf-kms/aws module's own floor of >= 1.9.0: HCL's
  # `||`/`&&` evaluation of the jira_integration variable's validation blocks (and
  # local.jira_integration_enabled in jira_lambda.tf) raises "Attempt to get attribute from null
  # value" on every Terraform version before 1.12.0 whenever jira_integration is left at its null
  # default - confirmed directly by bisection (fails at 1.11.0, passes cleanly at 1.12.0 and
  # every version tested up to 1.16.5). Declaring the real floor here, rather than working around
  # the older versions' behaviour in every affected expression, keeps those expressions as simple
  # `var.jira_integration == null || ...` guards instead of try(..., default)-wrapped ones.
  required_version = ">= 1.12.0"

  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
  }
}
