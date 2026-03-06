# Terraform Azure High Availability Infrastructure

This project provisions a high availability infrastructure on Microsoft Azure using Terraform. It includes virtual networks, virtual machines (Linux and Windows), a load balancer, a database, and common services like storage and logging.

## Project Structure

The project is organized into the following modules:

- **rgroup-n01742406**: Provisions the Resource Group.
- **network-n01742406**: Provisions the Virtual Network, Subnet, and Network Security Groups.
- **common-n01742406**: Provisions shared resources like Storage Accounts, Log Analytics Workspace, and Recovery Services Vault.
- **vmlinux-n01742406**: Provisions Linux Virtual Machines (CentOS) in an Availability Set with Nginx installed via remote-exec.
- **vmwindows-n01742406**: Provisions Windows Virtual Machines in an Availability Set.
- **datadisk-n01742406**: Provisions and attaches managed data disks to the virtual machines.
- **loadbalancer-n01742406**: Provisions a Standard Load Balancer for the Linux VMs.
- **database-n01742406**: Provisions an Azure Database for PostgreSQL Flexible Server.

## Prerequisites

- Terraform v1.0+
- Azure CLI installed and authenticated
- SSH Key pair generated at `~/.ssh/id_rsa_azure` (or update variables in `modules/vmlinux-n01742406/variables.tf `)

## Usage

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Plan the deployment:**
   ```bash
   terraform plan
   ```

3. **Apply the configuration:**
   ```bash
   terraform apply
   ```

## Outputs

The project outputs key information such as Resource Group Name, VM Hostnames/IPs, Load Balancer Name, and Database Name.

## TODO

- [ ] **Log Analytics Integration**: The Log Analytics Workspace is provisioned, and VM extensions (AzureMonitorLinuxAgent) are installed. However, Data Collection Rules (DCR) and full association are not yet configured.
- [ ] **Ansible Provisioning**: Currently, Nginx is installed via `remote-exec` on Linux VMs. Future improvements will move configuration management and Log Analytics agent configuration to Ansible.
- [ ] **Recovery Services Vault**: The resource is currently disabled (`count = 0`) in the common module. Needs to be enabled and configured for backups.
- [ ] **Database Configuration**: Firewall rules and advanced configurations for the PostgreSQL Flexible Server need to be finalized to allow connectivity from specific sources.
- [ ] **Load Balancer Health Probes**: Verify HTTP probe paths match the Nginx default configuration.
