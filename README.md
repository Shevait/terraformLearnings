# Terraform Learning Project

This repository contains various Terraform configurations for learning and practicing Infrastructure as Code (IaC) with AWS. The project includes different examples ranging from basic EC2 instances to more complex backend deployments with networking components.

## 📁 Project Structure

```
terraformLearnings/
├── BasicScripts/                    # Basic Terraform examples
│   ├── main.tf                      # Simple EC2 instance configuration
│   ├── terraform.tfstate            # Terraform state file
│   └── .terraform.lock.hcl          # Provider lock file
├── provision_backend_deployment/    # Complete backend infrastructure
│   ├── main.tf                      # VPC, networking, and EC2 configuration
│   ├── variables.tf                 # Input variables
│   ├── outputs.tf                   # Output values
│   ├── terraform.tfstate            # Terraform state file
│   └── .terraform.lock.hcl          # Provider lock file
├── terra_modules/                   # Modular Terraform approach
│   ├── main.tf                      # Module usage example
│   └── modules/
│       └── ec2-instance/            # Reusable EC2 module
│           ├── main.tf              # EC2 instance resource
│           ├── variables.tf         # Module variables
│           ├── outputs.tf           # Module outputs
│           └── terraform.tfvars     # Module-specific variables
├── .gitignore                       # Git ignore rules
└── README.md                        # This file
```

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with necessary permissions

### AWS Credentials Setup

Configure your AWS credentials using one of these methods:

```bash
# Method 1: AWS CLI
aws configure

# Method 2: Environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="ap-south-1"
```

## 📚 Project Components

### 1. BasicScripts
**Purpose**: Simple Terraform examples for beginners

**What it creates**:
- Basic EC2 instance in the default VPC
- Uses hardcoded values for learning purposes

**Key Features**:
- Simple EC2 instance creation
- Basic variable usage
- Output values for instance details

**Usage**:
```bash
cd BasicScripts
terraform init
terraform plan
terraform apply
```

### 2. provision_backend_deployment
**Purpose**: Complete backend infrastructure setup with proper networking

**What it creates**:
- Custom VPC with public subnet
- Internet Gateway and Route Table
- Security Group with HTTP/HTTPS/SSH access
- EC2 instance in the public subnet

**Key Features**:
- Complete networking setup
- Security group configuration
- Configurable variables
- Output values for connection details

**Configuration Variables**:
- `project`: Project name prefix (default: "my-app")
- `aws_region`: AWS region (default: "ap-south-1")
- `vpc_cidr`: VPC CIDR block (default: "10.0.0.0/16")
- `public_subnet_cidr`: Public subnet CIDR (default: "10.0.1.0/24")
- `az`: Availability zone (default: "ap-south-1a")
- `ssh_cidr`: Allowed CIDR for SSH access (default: "0.0.0.0/0")
- `key_name`: EC2 key pair name (default: "test")
- `ami`: AMI ID (default: "ami-0f918f7e67a3323f0")
- `instance_type`: EC2 instance type (default: "t2.micro")

**Usage**:
```bash
cd provision_backend_deployment
terraform init
terraform plan
terraform apply
```

### 3. terra_modules
**Purpose**: Demonstrates modular Terraform approach

**What it creates**:
- EC2 instance using a reusable module
- Shows best practices for module organization

**Key Features**:
- Reusable EC2 module
- Module-based architecture
- Separation of concerns

**Usage**:
```bash
cd terra_modules
terraform init
terraform plan
terraform apply
```

## 🔧 Customization

### Creating Custom Variables

Create a `terraform.tfvars` file to override default values:

```hcl
# terraform.tfvars
project = "my-custom-app"
aws_region = "us-west-2"
instance_type = "t3.small"
key_name = "my-key-pair"
ssh_cidr = "203.0.113.0/24"  # Your IP address
```

### Security Considerations

⚠️ **Important Security Notes**:

1. **SSH Access**: The default configuration allows SSH from anywhere (`0.0.0.0/0`). For production, restrict this to your IP address:
   ```hcl
   ssh_cidr = "YOUR_IP_ADDRESS/32"
   ```

2. **Key Pairs**: Ensure you have the corresponding private key for the key pair specified in `key_name`.

3. **State Files**: Never commit `.tfstate` files to version control as they may contain sensitive information.

## 📋 Common Commands

```bash
# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure
terraform destroy

# Format code
terraform fmt

# Validate configuration
terraform validate

# Show current state
terraform show

# List resources
terraform state list
```

## 🏗️ Infrastructure Details

### Backend Deployment Architecture

```
Internet Gateway
       │
   ┌───▼───┐
   │  VPC  │ (10.0.0.0/16)
   │       │
   │   ┌───▼───┐
   │   │Public │ (10.0.1.0/24)
   │   │Subnet │
   │   │       │
   │   │   ┌───▼───┐
   │   │   │ EC2   │
   │   │   │Instance│
   │   │   └───────┘
   │   └───────────┘
   └───────────────┘
```

### Security Group Rules

| Type | Protocol | Port | Source | Description |
|------|----------|------|--------|-------------|
| Inbound | TCP | 22 | SSH CIDR | SSH access |
| Inbound | TCP | 80 | 0.0.0.0/0 | HTTP access |
| Inbound | TCP | 443 | 0.0.0.0/0 | HTTPS access |
| Outbound | All | All | 0.0.0.0/0 | All outbound traffic |

## 🐛 Troubleshooting

### Common Issues

1. **Provider Authentication Error**
   ```
   Error: No valid credential sources found
   ```
   **Solution**: Configure AWS credentials using `aws configure` or environment variables.

2. **Key Pair Not Found**
   ```
   Error: InvalidKeyPair.NotFound
   ```
   **Solution**: Create a key pair in the AWS console or update the `key_name` variable.

3. **Insufficient Permissions**
   ```
   Error: AccessDenied
   ```
   **Solution**: Ensure your AWS user/role has the necessary IAM permissions.

### Useful Debugging Commands

```bash
# Enable debug logging
export TF_LOG=DEBUG
terraform apply

# Check AWS credentials
aws sts get-caller-identity

# List available AMIs
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*"
```

## 📖 Learning Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes
5. Submit a pull request

## 📄 License

This project is for educational purposes. Feel free to use and modify as needed.

## ⚠️ Disclaimer

This is a learning project. The configurations are designed for educational purposes and may not follow all production best practices. Always review and customize configurations for your specific use case and security requirements.

---

**Happy Learning! 🚀**
