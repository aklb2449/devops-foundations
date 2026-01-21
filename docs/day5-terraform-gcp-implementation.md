# Day 5 – Terraform Implementation on GCP (Compute Engine)

## Objective
Provision Google Cloud infrastructure using Terraform following Infrastructure as Code (IaC) best practices.

---

## Tools Used
- Terraform
- Google Cloud Platform (GCP)
- Google Compute Engine
- Git & GitHub

---

## Terraform Directory Structure

```text
terraform/gcp-day1/
├── versions.tf
├── provider.tf
├── variables.tf
├── network.tf
├── compute.tf
├── outputs.tf
├── terraform.tfvars
├── .terraform.lock.hcl

Each file has a clear responsibility to keep the code modular and readable.

Provider Configuration

Terraform uses the GCP provider authenticated via a service account.

Authentication method:

Service account JSON

Environment variable GOOGLE_APPLICATION_CREDENTIALS

export GOOGLE_APPLICATION_CREDENTIALS=~/.gcp/tjcerraform-sa.json

Resources Created
1. VPC Network

Custom VPC

Auto-mode subnets

2. Firewall Rule

Allows SSH (TCP port 22)

Applied only to the custom VPC

3. Compute Engine VM

Debian 12 image

e2-micro machine type

Public IP enabled

OS Login enabled via metadata

Terraform Workflow

The following commands were used:

terraform init
terraform plan
terraform apply


init initializes providers

plan previews infrastructure changes

apply creates resources

Terraform output displayed the VM public IP after successful creation.

Git Best Practices Followed

Committed:

Terraform .tf files

.terraform.lock.hcl

.gitignore

Ignored:

.terraform/

terraform.tfstate

Service account JSON keys

This ensures security and clean version control.

Outcome

Infrastructure successfully created using Terraform

No manual configuration via cloud console

Infrastructure fully reproducible using code
