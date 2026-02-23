# AWS EC2 Automation

This Bash script automates the installation of **AWS CLI** and provisioning of **EC2 instances** on a Linux system.  
It handles AWS CLI installation, credential configuration, instance creation, and monitoring of the instance state.

---

## Features

- Detects existing AWS CLI installation and optionally upgrades it
- Installs AWS CLI v2 on Linux if not already installed
- Configures AWS credentials
- Creates EC2 instances with:
  - Specified **AMI ID**
  - **Instance type** (Free Tier eligible)
  - **Key pair**
  - **Subnet and security groups**
  - Custom **instance name**
- Waits for the EC2 instance to reach the **running** state
- Handles errors and missing parameters

---

## Requirements

- Ubuntu or compatible Linux system  
- Bash shell  
- Internet connection to download AWS CLI  
- AWS account with proper IAM permissions for EC2 provisioning  

---

## Usage

```bash
# Navigate to your script directory
cd ~/Shell-Scripting/projects/AWS-EC2-Automation

# Run the deployment script
./install-aws-cli.sh
```
## Deployment Overview

The script will:

- Check if AWS CLI is already installed
- Install or update AWS CLI if needed
- Configure credentials (prompted interactively)
- Create an EC2 instance and wait until it’s running

---

## Technologies Used

- **AWS EC2** – Cloud compute service
- **AWS CLI** – Command-line interface for AWS
- **Bash** – Automation scripting
- **Linux / Ubuntu** – Operating system environment

---

## Notes

- Ensure sufficient disk space before running the script
- Script can be rerun to update AWS CLI or deploy new EC2 instances
- Modify script parameters for different AMI, instance type, key pair, subnet, or security groups
