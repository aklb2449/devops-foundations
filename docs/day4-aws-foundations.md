# Day 4 – AWS Foundations (DevOps View)

## AWS Mental Model
AWS can be understood as Linux infrastructure running in the cloud. EC2 provides compute similar to Linux servers, VPC provides networking isolation, Security Groups act as firewalls, IAM controls access, and CloudWatch provides logging and monitoring.

---

## Core AWS Services (Initial Focus)

### Compute
- **EC2**: Virtual Linux servers in the cloud

### Networking
- **VPC**: Isolated virtual network
- **Subnets**: Network segmentation
- **Route Tables**: Control traffic flow
- **Internet Gateway**: Public internet access
- **NAT Gateway**: Outbound internet for private resources

### Security
- **IAM**: Identity and access management
- **Security Groups**: Instance-level firewalls

### Storage
- **S3**: Object storage for files and backups

### Monitoring
- **CloudWatch**: Centralized logs and metrics

---

## Linux to AWS Concept Mapping

| Linux / On-Prem | AWS Equivalent | Explanation |
|-----------------|---------------|-------------|
| Physical Server | EC2 Instance | Virtual machine running Linux |
| NIC | ENI | Network interface for EC2 |
| Firewall Rules | Security Groups | Stateful firewall controlling traffic |
| Router | Route Table | Defines traffic direction |
| Logs | CloudWatch | Centralized logging and metrics |
| Cron | EventBridge | Scheduled task execution |
| Disk | EBS | Persistent block storage |

---

## Key Takeaway
AWS does not replace Linux concepts; it abstracts and scales them. Understanding Linux and networking makes AWS easier to design, operate, and troubleshoot.
