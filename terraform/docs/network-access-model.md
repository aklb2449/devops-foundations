# Network Access Model (Dev vs Prod)

## Overview
This project uses environment-based controls to manage network exposure and SSH access.
Public IP assignment and SSH access are handled independently to follow security best practices.

## Public IP vs SSH Access
- Public IP controls whether a VM is reachable from the internet.
- SSH access is controlled separately using firewall rules.
- A public IP alone does not allow SSH access.

## Development Environment
- Public IP: Enabled
- SSH Access: Enabled (port 22 open from 0.0.0.0/0)
- Purpose: Easy access for testing and development

## Production Environment
- Public IP: Disabled
- SSH Access: Disabled
- Access Method: Private networking (IAP or bastion host)
- Purpose: Secure-by-default production infrastructure

## Terraform Implementation
- `enable_public_ip` controls public IP assignment in the compute module
- `enable_public_ssh` controls SSH firewall rules in the network module
- Defaults are secure (false) and overridden only in dev

## OS Login
OS Login is enabled on all VMs to centralize authentication and authorization using GCP IAM.
Network access and identity management are handled independently.

## Security Rationale
- Minimizes attack surface in production
- Prevents accidental public SSH exposure
- Allows controlled access using approved mechanisms
