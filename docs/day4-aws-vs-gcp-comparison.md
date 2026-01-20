# Day 4 – AWS vs GCP Comparison (DevOps Perspective)

## High-Level Philosophy

| Aspect | AWS | GCP |
|------|-----|-----|
| Design Approach | Service-heavy, granular | Clean, platform-oriented |
| Networking Model | Regional VPC | Global VPC |
| Learning Curve | Steeper | Simpler for beginners |
| Enterprise Adoption | Very high | High (especially data-driven orgs) |

---

## Compute Comparison

| Concept | AWS | GCP |
|-------|-----|-----|
| Virtual Machines | EC2 | Compute Engine |
| VM Images | AMI | Images |
| Scaling | Auto Scaling Groups | Managed Instance Groups |

---

## Networking Comparison

| Concept | AWS | GCP |
|-------|-----|-----|
| Virtual Network | VPC (regional) | VPC (global) |
| Subnets | Regional | Regional |
| Firewall | Security Groups + NACLs | VPC Firewall Rules |
| Routing | Route Tables | Routes |
| NAT | NAT Gateway | Cloud NAT |

---

## Identity & Access Management

| Concept | AWS | GCP |
|-------|-----|-----|
| IAM Scope | Global | Global |
| Access Control | Policies attached to users/roles | Roles bound to identities |
| Best Practice | IAM Roles | Service Accounts |

---

## Storage Comparison

| Concept | AWS | GCP |
|-------|-----|-----|
| Object Storage | S3 | Cloud Storage |
| Block Storage | EBS | Persistent Disk |
| Archive Storage | Glacier | Archive Storage |

---

## Logging & Monitoring

| Concept | AWS | GCP |
|-------|-----|-----|
| Logs | CloudWatch Logs | Cloud Logging |
| Metrics | CloudWatch Metrics | Cloud Monitoring |
| Alerts | CloudWatch Alarms | Alerting Policies |

---

## Scheduling & Automation

| Concept | AWS | GCP |
|-------|-----|-----|
| Scheduled Jobs | EventBridge | Cloud Scheduler |
| Automation | Lambda + EventBridge | Cloud Functions + Scheduler |

---

## DevOps & CI/CD Ecosystem

| Area | AWS | GCP |
|----|-----|-----|
| Native CI/CD | CodePipeline | Cloud Build |
| Container Platform | EKS / ECS | GKE |
| IaC Preference | Terraform | Terraform |

---

## When to Choose Which

| Scenario | Better Choice |
|--------|--------------|
| Multi-service enterprise workloads | AWS |
| Data, analytics, ML-heavy workloads | GCP |
| Kubernetes-first environments | GCP |
| Legacy enterprise migration | AWS |

---

## Key Takeaway

AWS and GCP solve the same problems using different abstractions. A strong DevOps engineer focuses on fundamentals like Linux, networking, IAM, and automation rather than memorizing provider-specific services.
