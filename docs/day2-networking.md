### Packet Flow Explanation
In a typical application flow, a client first resolves the service hostname using DNS. The request then travels from the client to the network gateway, reaches a load balancer (if present), and is forwarded to the backend service listening on a specific port. The service processes the request and sends the response back through the same path in reverse.

### Debugging “Service Not Reachable”
When a service is not reachable, I first check whether the service is running using systemctl and confirm that it is listening on the expected port using ss or netstat. Next, I verify local firewall rules and routing to ensure traffic is allowed. I then check logs using journalctl to identify application or startup errors. If needed, I trace the network path and confirm DNS resolution is working correctly.

### Mapping to AWS / GCP
In cloud environments, the network interface maps to an ENI (AWS) or NIC (GCP), and routing is controlled using route tables. Security Groups or firewall rules determine which ports are accessible. Load balancers handle traffic distribution at Layer 4 or Layer 7, similar to local reverse proxies. The same troubleshooting approach applies by checking instance health, security rules, and application logs.
