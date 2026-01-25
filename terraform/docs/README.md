# Terraform – GCP Infrastructure (DevOps Foundations)

This repository demonstrates a production-oriented Terraform setup on Google Cloud Platform, focusing on security, modularity, and environment isolation.

## Highlights
- Modular Terraform design (network & compute modules)
- Environment-based configuration (dev and prod)
- Remote state management using a GCS backend
- Secure VM access using OS Login and Identity-Aware Proxy (IAP)
- Clear separation of public IP exposure and SSH access
- Full infrastructure lifecycle management (plan, apply, destroy)

## Documentation
Start here:
1. **terraform-advanced-architecture.md** – Overall design and Terraform structure  
2. **network-access-model.md** – Dev vs prod access and security model  
3. **gcp-ssh-oslogin-troubleshooting.md** – SSH and OS Login troubleshooting guide

## Scope
This project intentionally focuses on:
- Infrastructure design patterns
- Security-first defaults
- Real-world Terraform limitations and migration strategies

Application deployment and CI/CD are out of scope for this phase.
