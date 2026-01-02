## Architecture

This project provisions **production-style AWS infrastructure** using Terraform with a modular design.

**Core components:**

- **Networking**
  - VPC with public and private subnets across multiple AZs
  - Internet Gateway for public access
  - NAT Gateway for outbound access from private subnets

- **Compute**
  - Application Load Balancer (ALB)
  - Auto Scaling Group (ASG) of EC2 instances
  - Security groups scoped by role (ALB → app → database)

- **Database**
  - Amazon RDS (private subnet only)
  - Credentials injected securely via CI (not committed to Git)

- **State Management**
  - Remote Terraform state stored in **S3**
  - **DynamoDB state locking** to prevent concurrent writes
    
## CI/CD & Workflow

Infrastructure changes follow a **pull-request–driven workflow** using GitHub Actions.

### Pull Requests

On every pull request to `main`, GitHub Actions automatically runs:

- `terraform fmt -check`
- `terraform validate`
- `terraform plan`

This ensures:

- Consistent formatting
- Early validation errors
- Full visibility into proposed infrastructure changes before merge

  ### Apply on Main (Gated)

When changes are merged to `main`:

- `terraform apply` runs via GitHub Actions
- AWS authentication uses **OIDC role assumption** (no static access keys)
- Applies are **gated behind a GitHub Environment approval** (`prod`)

This prevents accidental or unreviewed infrastructure changes.

## Security Practices

- No long-lived AWS credentials stored in GitHub
- Secrets (DB credentials) injected at runtime via GitHub Actions secrets
- Database deployed in private subnets only
- Security group rules scoped to least privilege
- Terraform state protected by locking to avoid race conditions
