#terraform-advanced-architecture.md (full content)
# Terraform — Advanced Architecture (GCP)

## Objective
Design and operate Google Cloud infrastructure using production-grade Terraform practices. The goal is repeatable, safe, auditable infrastructure changes with environment separation, secure access, and clear migration procedures.

---

## 1. High-level architecture
- **Modules**: Reusable building blocks (network, compute, etc.). Modules contain the smallest logical unit of infrastructure.
- **Environment folders**: `envs/dev`, `envs/prod` — each environment declares modules and passes intent via variables.
- **Remote state**: Backend stored in a GCS bucket with locking and separation per environment.
- **Access model**: Dev allows convenience (public IPs), Prod enforces security (no public IP, IAP for SSH).

---

## 2. Folder / repo layout (single source of truth)


terraform/
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── envs/
│   ├── dev/
│   │   ├── provider.tf
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── prod/
│       ├── provider.tf
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── docs/
├── README.md
├── terraform-advanced-architecture.md
├── network-access-model.md
└── gcp-ssh-oslogin-troubleshooting.md

---

## 3. Key design principles (why this pattern)
1. **Environment separation** — prevents accidental dev→prod changes. State backend per environment avoids collisions.
2. **Modules** — reduce duplication and enforce consistent defaults (security posture in prod).
3. **Immutable and safe changes** — do not modify foundational resources in place when unsafe (e.g., changing auto VPC → custom VPC requires replacement).
4. **Least privilege & access layering** — IAM + OS Login + IAP, not open public SSH in production.
5. **Documented decisions** — every structural change gets a short runbook (docs/) and commit history.

---

## 4. Backend & state
- Use a GCS bucket per environment (or a prefix) and enable object versioning.
- Enable state locking with a backend that supports locks (GCS with `storage.googleapis.com` + state locks via `terraform init` config).
- Never commit `*.tfstate`, `*.tfstate.backup`, or `.terraform/` to Git.

Example `backend.tf` (envs):
```hcl
terraform {
  backend "gcs" {
    bucket = "devops-tf-state-<your-unique-bucket>"
    prefix = "gcp/prod"
  }
}


5. Authentication & best practices


Prefer Application Default Credentials (ADC) for interactive work: gcloud auth application-default login.


For CI/CD, use a short-lived service account with least privilege and use Workload Identity where possible.


Never store service account keys in the repo.


Export GOOGLE_APPLICATION_CREDENTIALS only in CI or in a secured shell session if needed.



6. Module responsibilities (concise)
network module


Create VPC (custom mode)


Create subnets, route tables (if required)


Create firewall rules (IAP, conditional public SSH)


Export network_name, subnet_name outputs


compute module


Create GCE instance(s) with enable-oslogin = "TRUE"


Accept network_name, subnet_name, enable_public_ip variables


Export public_ip and private_ip outputs



7. Access model — Dev vs Prod


Dev


Public IPs allowed (for quick debugging)


Public SSH firewall rule allowed (conditional)


IAP enabled (optional)




Prod


No public IPs on instances


No public SSH firewall rules


SSH access only via IAP (firewall rule 35.235.240.0/20 -> TCP:22)


OS Login enforced on instances


IAM: users/groups must have roles/iap.tunnelResourceAccessor and roles/compute.osLogin or roles/compute.osAdminLogin





8. Migration and blue/green pattern (explicit steps)
Problem: A VM cannot change its VPC once created. Switching from auto-mode VPC to custom-mode VPC requires replacement of the VPC and any dependent resources — destructive in place.
Safe approach (blue/green):


Do not modify the existing legacy resources in-place.


Create a new VPC (e.g., devops-vpc-prod-v2).


Create a new subnet inside the new VPC.


Create new VM(s) (green) inside the new subnet.


Validate green instance(s) (connectivity, services).


Switch traffic — update DNS or switch load balancers to the green backend.


When validated, decommission legacy (old) VM and old network resources as a separate controlled change.


Commands (example sequence):
# detach old resources from terraform control if necessary:
terraform state rm module.compute.google_compute_instance.vm

# update envs/prod/main.tf to reference new module compute_green
terraform init
terraform plan
terraform apply


9. Typical operations: a safe checklist
Before terraform apply (prod):


git status clean and commit all code + docs


terraform init (backend configured)


terraform plan — review carefully (no implicit destroys)


If plan includes resource replacements of foundational resources, stop and review


terraform apply with CI or manual approval


After apply:


Validate instance access (IAP SSH for prod)


Run smoke tests


Monitor logs/metrics (Cloud Monitoring / Cloud Logging)



10. Git & documentation guidance


Commit code and docs together with meaningful messages.


Minimal required docs:


terraform-advanced-architecture.md (this file)


network-access-model.md (reads like architecture + migration)


gcp-ssh-oslogin-troubleshooting.md (runbook)




Example commit sequence:


git add terraform/modules terraform/envs terraform/docs
git commit -m "Infra: advanced terraform architecture, custom VPC, IAP access (dev/prod)"
git push origin main


11. Troubleshooting common issues (short list)


Host key changed: ssh-keygen -R <IP> then reconnect


VPC replacement blocked: dependent resources (VMs, firewalls) must be migrated or removed from state first


IAP permission denied: ensure roles/iap.tunnelResourceAccessor assigned


Missing ADC / credentials: gcloud auth application-default login or set GOOGLE_APPLICATION_CREDENTIALS



12. Next recommended topics


Cloud NAT for private instances' outbound internet access


Instance Templates and Managed Instance Groups (MIGs) for scale


Private GKE or EKS patterns (if moving to containers)


Workload Identity & CI/CD integration for safe deployments



13. Final note
This repo is intentionally opinionated: security-first for prod, convenience for dev, and repeatable, auditable steps for migrations. Keep code and docs synchronized; always prefer safe, small steps rather than sweeping changes in production.

