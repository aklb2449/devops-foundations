# Day 4 – GCP Foundations (DevOps View)

## GCP Mental Model
Google Cloud Platform can be understood as Linux infrastructure running inside Google-managed data centers. Compute Engine provides virtual machines, VPC handles networking, firewall rules control traffic, IAM manages access, and Cloud Logging and Monitoring provide observability.

---

## Core GCP Services (Initial Focus)

### Compute
- **Compute Engine**: Virtual machines running Linux or Windows

### Networking
- **VPC**: Global virtual network
- **Subnets**: Regional IP ranges
- **Routes**: Control packet flow
- **Cloud NAT**: Outbound internet access for private instances

### Security
- **IAM**: Identity and access management
- **Firewall Rules**: Network-level traffic control

### Storage
- **Cloud Storage**: Object storage for files and backups
- **Persistent Disk**: Block storage for VMs

### Monitoring & Logging
- **Cloud Monitoring**: Metrics and alerts
- **Cloud Logging**: Centralized logs

---

## Linux to GCP Concept Mapping

| Linux / On-Prem | GCP Equivalent | Explanation |
|-----------------|----------------|-------------|
| Physical Server | Compute Engine VM | Virtual machine running Linux |
| NIC | VPC Network Interface | Network interface attached to VM |
| Firewall Rules | VPC Firewall Rules | Stateful traffic filtering |
| Router | Routes | Define packet forwarding |
| Logs | Cloud Logging | Centralized log management |
| Cron | Cloud Scheduler | Scheduled job execution |
| Disk | Persistent Disk | VM-attached storage |

---

## Key Takeaway
GCP closely aligns with traditional Linux and networking concepts but introduces a global VPC model. Understanding Linux fundamentals makes operating GCP services predictable and easier to manage.
 
