# GCP SSH with OS Login – Issue & Resolution

## Problem
SSH using IP failed with:
Permission denied (publickey)

## Root Cause
- OS Login was enabled on the VM
- Incorrect SSH username was used
- SSH key was not registered with OS Login

## Resolution Steps
1. Registered SSH key using:
   gcloud compute os-login ssh-keys add

2. Identified OS Login username using:
   gcloud compute os-login describe-profile

3. Connected using:
   ssh <oslogin_username>@<public_ip>

## Outcome
- SSH access successful
- IAM-based access control enforced
- No manual key management required

## Best Practice
Always use OS Login for production GCP VMs.
