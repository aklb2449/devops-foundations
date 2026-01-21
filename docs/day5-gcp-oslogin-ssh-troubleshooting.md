# Day 5 – GCP OS Login SSH Issue and Resolution

## Objective
Document the SSH access issue faced while connecting to a Terraform-created GCP VM and the steps taken to resolve it.

---

## Initial SSH Attempt

SSH was attempted using:

```bash
ssh <username>@<VM_PUBLIC_IP>
Result:

Permission denied (publickey)

VM SSH Configuration

The VM was configured with OS Login enabled:

metadata = {
  enable-oslogin = "TRUE"
}


This means:

SSH access is controlled via IAM

Static SSH keys are not used

Why the Issue Occurred

Even though the user was:

Project Owner

Firewall rules were correct

VM was running

SSH still failed because:

OS Login requires explicit IAM roles

Project Owner role alone is insufficient

OS Login API must be enabled

OS Login user profile must be initialized

Resolution Steps

Added IAM role:

Compute OS Admin Login

Enabled OS Login API.

Installed Google Cloud CLI:

sudo apt install google-cloud-cli


Authenticated locally:

gcloud auth login
gcloud config set project <PROJECT_ID>


Bootstrapped OS Login profile:

gcloud compute ssh devops-terraform-vm --zone=asia-south1-a


This step created the OS Login user and injected ephemeral SSH keys.

Final Result

After bootstrapping OS Login:

SSH access worked successfully

Normal ssh username@IP worked

No manual SSH key creation was required

Key Learnings

OS Login is IAM-driven, not key-driven

Owner role ≠ OS Login permission

gcloud compute ssh is required once to initialize OS Login

This approach improves security and access control


Save & exit.

