# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  backend "s3" {
    region = "us-east-1"                     # aft main region
    bucket = "terraform-states-058264455607" # s3 bucket name
    key    = "aft-setup.tfstate"
  }
}

module "aft" {
  source                      = "github.com/aws-ia/terraform-aws-control_tower_account_factory"
  ct_management_account_id    = var.ct_management_account_id
  log_archive_account_id      = var.log_archive_account_id
  audit_account_id            = var.audit_account_id
  aft_management_account_id   = var.aft_management_account_id
  ct_home_region              = var.ct_home_region
  tf_backend_secondary_region = var.tf_backend_secondary_region

  vcs_provider                                  = "github"
  account_request_repo_name                     = "${var.github_username}/mspv2-aft-account-request-core"
  account_provisioning_customizations_repo_name = "${var.github_username}/mspv2-aft-account-provisioning-customizations-core"
  global_customizations_repo_name               = "${var.github_username}/mspv2-aft-global-customizations-core"
  account_customizations_repo_name              = "${var.github_username}/mspv2-aft-account-customizations-core"
}