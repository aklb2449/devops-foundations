# Network Access Model (Dev vs Prod)

## Overview
This project uses environment-based controls to manage network exposure and SSH access.
Public IP assignment and SSH access are intentionally decoupled to follow cloud security best practices.

---

## Public IP vs SSH Access (Important Distinction)

- A **public IP** only makes a VM reachable from the internet.
- **SSH access** is controlled independently via firewall rules and IAM.
- Having a public IP does **not** automatically allow SSH access.

This separation prevents accidental exposure of production systems.

---

## Development Environment (dev)

- Public IP: Enabled
- SSH Access: Enabled  
  - Firewall rule allows TCP/22 from `0.0.0.0/0`
- Purpose:
  - Faster iteration
  - Easier debugging
  - Reduced operational friction during development

This configuration is intentionally permissive but isolated to dev only.

---

## Production Environment (prod)

- Public IP: Disabled
- SSH Access: Disabled from public internet
- Access Method:
  - Google IAP (Identity-Aware Proxy)
  - Optional bastion host (future enhancement)
- Purpose:
  - Minimize attack surface
  - Enforce identity-based access
  - Prevent direct internet exposure

Production access is **identity-driven**, not network-driven.

---

## Terraform Controls

| Concern | Terraform Variable | Module |
|------|-------------------|--------|
| Public IP | `enable_public_ip` | compute |
| Public SSH | `enable_public_ssh` | network |

Defaults are secure (`false`) and overridden only in development environments.

---

## OS Login

OS Login is enabled on all virtual machines:
- Centralizes authentication using GCP IAM
- Eliminates local SSH key sprawl
- Allows access auditing and role-based control

OS Login handles **who** can log in,  
Firewall + networking controls handle **from where**.

---

## Security Rationale

- Reduced blast radius
- Clear separation of responsibilities
- Environment-specific security posture
- Safe defaults with explicit opt-in for exposure
