# Aws-Vpc-Subnets-Env

This project provisions an AWS VPC & networking(optional if you choose true in tfvars) related resources using Terraform in a modular structure with CI/CD automation powered by GitHub Actions. It supports multi-environment deployments (dev, prod) and includes Infracost for cost estimation.

 
## Prerequisites
## Create an S3 Bucket for Terraform State (AWS Console)
Step 1: Sign In
Go to https://s3.console.aws.amazon.com/s3 and log into your AWS account.

Step 2: Create Bucket
Click [Create bucket].

Fill out the bucket details:

Bucket name: your-terraform-state-bucket (must be globally unique)

AWS Region: Choose the region Terraform will run in (e.g., us-east-1)

Step 3: Configure Options
Leave the following as default:

Object Ownership: Accept "ACLs disabled (recommended)"

Block Public Access: Leave all boxes checked 

Bucket Versioning: Optional (recommended for state tracking)

Encryption: Optional (you can enable SSE-S3 or SSE-KMS for additional security)

Step 4: Create the Bucket
Click [Create bucket] at the bottom.

## Create DynamoDB table for state locking
1.Open DynamoDB
In the Search bar, type DynamoDB

Click DynamoDB service

2.Create table
Click Create table

Fill in:

Table name:
For dev → terraform-locks-dev
For prod → terraform-locks-prod

Partition key:
Name: LockID
Type: String

Leave Sort key unchecked (not required for Terraform locking)

Capacity mode:

3.Create table
Click Create table

Wait for status to become Active (takes a few seconds)

 ## Project Structure

```
terraform/
  environments/
    dev/
      backend.tf
      main.tf
      variables.tf
      terraform.tfvars
    prod/
      backend.tf
      main.tf
      variables.tf
      terraform.tfvars
  modules/
    vpc/
      main.tf
      outputs.tf
      variables.tf
      subnets.tf
      public-route.tf
      private-route.tf
      internet-gateway.tf
      nat-gateway.tf
      data.tf
.github/
  workflows/
    deploy.yml
  ```

## Update the terraform.tfvars 
update the below values according to your requirement.
```
aws_region                = ""
vpc_cidr                  = ""
public_subnet_cidrs       = ["", ""]
private_subnet_cidrs      = ["", ""]
environment               = ""
Project = ""
Owner   = ""
create_internet_gateway   = false
create_nat_gateway        = false
create_public_route_table = false
create_private_route_table= false
create_subnets            = true
```

##  Required Secrets in GitHub

In your GitHub repo, go to **Settings → Environments → prod and dev, dev-plan and prod-plan->add Environment secrets** and add:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

TF_BUCKET ---s3 bucket name

TF_KEY    ---any name can give example terraform.tfstate.dev.EC2. for each environment you have to give different name.

TF_REGION --- s3 bucket region ex us-east-1

TF_DYNAMODB ---dynamodb table name.

INFRACOST_API_KEY --- key can get it from infracost.io

# Environments
We need to add total four environments that is dev,prod and dev-plan,prod-plan. to avoid manuall reviewer approval for stage branch plan pipeline I used these two envronments(dev-plan and prod-plan) here we are not selecting any reviewer under deployment reviewer.

# Add Collaborators
Go to your repo → Settings → Collaborators

Click "Invite a collaborator"

Enter your teammate’s GitHub username

Choose appropriate access (usually Write or Admin)

Send invite

Note: If you're the owner, you cannot add yourself — you already have full access.

# Add a GitHub Environment

Go to Settings → Environments

Click "New environment", name it dev

Under "Deployment protection rules", click "Required reviewers"

Add your GitHub username (or a teammate)
Click Save

This will enforce manual approval before applying infrastructure.

# Workflow
in deployment.yml file choose the env either dev or prod and dev-plan or prod-plan under plan pipeline
example:
environment: ${{ github.event.inputs.environment ||'dev-plan'}}
env:
      ENV: ${{ github.event.inputs.environment || 'dev' }}

for the Apply pipeline  :
example
 environment: ${{ github.event.inputs.environment || 'dev' }}
    defaults:
      run:
        working-directory: terraform/environments/${{ github.event.inputs.environment || 'dev' }}


 Trigger on stage branch

Automatically runs terraform init, plan, and Infracost report

Skips apply step (for preview only)

 Trigger on main branch (Manual Approval)

Go to Actions → Terraform Azure Psql DB CI/CD → Run workflow

Select the envronment prod or dev

Enter input yes

Waits for approval (based on environment reviewers)

Terraform plan runs

Waits for approval (based on environment reviewers)

Once approved, resources are deployed

# Outputs
output "vpc_id" 

below out put appear when you choose true in the tfvars 

output "public_subnet_ids"

output "private_subnet_ids" 

output "internet_gateway_id"

output "nat_gateway_ids"

output "public_route_table_id"

output "private_route_table_id" 

##  Cleanup
```terminal

terraform init `
  -backend-config="bucket=bucket name" `
  -backend-config="key=bucket key" `
  -backend-config="region=us-east-1" `
  -backend-config="dynamodb_table=name of dynamodb table" `
  -backend-config="encrypt=true"

terraform destroy 
```

# References
AWS VPC - Terraform Docs

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc