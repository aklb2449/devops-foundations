# Terraform Advanced – GCP Implementation

## Objective
Design and deploy GCP infrastructure using production-grade Terraform practices.

## Architecture Overview
- Modular Terraform (network & compute modules)
- Environment-based structure (dev)
- Remote state stored in GCS
- Secure authentication using Application Default Credentials (ADC)

## Terraform Structure
- modules/network: VPC and firewall rules
- modules/compute: VM provisioning
- envs/dev: Environment-specific configuration

## State Management
- Terraform backend configured with GCS
- State stored remotely with locking enabled
- No local state files committed

## Authentication
- Used `gcloud auth application-default login`
- No service account keys stored locally
- Backend authentication handled before provider initialization

## VM Access
- OS Login enabled via instance metadata
- SSH access controlled by IAM roles
- Accessed VM using SSH over public IP with OS Login username

## Key Learnings
- Terraform state is the source of truth
- Refactoring code does not recreate infrastructure
- OS Login provides centralized SSH access control
- Modular Terraform scales across environments
