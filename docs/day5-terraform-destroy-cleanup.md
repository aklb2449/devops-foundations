Day 5 – Terraform Destroy and Infrastructure Cleanup

## Objective
Safely remove all cloud resources created using Terraform after completing validation and testing.

---

## Why Terraform Destroy Is Required

Terraform-managed infrastructure should be:
- Created when needed
- Tested and validated
- Destroyed when no longer required

This prevents:
- Unnecessary cloud costs
- Unused resources
- Security exposure

---

## Pre-Destroy Validation

Before destroying infrastructure, the Terraform working directory was verified.

```bash
cd terraform/gcp-day1
terraform state list

This command confirmed the resources currently managed by Terraform.
Destroy Plan Review

Terraform destroy was reviewed before execution using:

terraform plan -destroy

This command showed all resources scheduled for deletion and ensured no unexpected resources would be removed.
Destroy Execution

The infrastructure was destroyed using:

terraform destroy

Terraform prompted for confirmation:

Do you really want to destroy all resources?

After confirming with yes, Terraform removed all resources.
Resources Destroyed

The following Terraform-managed resources were deleted:

    google_compute_instance.vm

    google_compute_firewall.allow_ssh

    google_compute_network.vpc

Post-Destroy Verification

After completion, Terraform confirmed:

Destroy complete! Resources: 3 destroyed.

Additionally, the GCP Console was checked to verify that:

    No VM instances were running

    No public IPs were allocated

Outcome

    All cloud resources created by Terraform were removed

    No billing charges remained

    Terraform configuration files were retained for reuse

    Terraform state files remained local and were not committed to Git

Key Learnings

    Terraform destroy is a critical part of the IaC lifecycle

    terraform plan -destroy helps prevent accidental deletion

    Infrastructure should be treated as disposable

    Proper cleanup reflects mature DevOps practices
