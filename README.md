# Terraform Infrastructure Project

## Overview

This repository infrastructure definitions written in Terraform to manage and provision cloud resources:
- network
- nginx server hosted on compute engine
- MySQL database
- cloud storage

## Repository Structure
```
terraform-infra/
├── terraform/
│   ├── main.tf                  # main terraform configuration
│   ├── variables.tf             # input variables for the infrastructure
│   ├── backend.tf               # remote backend configuration
│   ├── providers.tf
│   ├── modules/                 # module definitions
│   │   ├── compute/
│   │   ├── network/
│   │   ├── storage/
│   │   └── database/
│   └── envs/                    # environment-specific configurations
│       └── dev/
│           ├── terraform.tfvars
│           └── variables.tf
├── .github/workflows/ci-cd.yml  # gitHub actions workflow for CI/CD
├── .env.example                 # Example environment variables file
└── README.md                    # this file
```

## Prerequisites
1. **Terraform**: Install [Terraform](https://www.terraform.io/downloads).
1. **Environment Variables**: define required environment variables - use [.env.example](./.env.example) as reference

## Usage

### Initialize Terraform
```bash
terraform init
```

### Validate Configuration
```bash
make validate
```

### Run checkov linting
```bash
make lint
```

### Plan Changes
```bash
make plan
```

### Apply Changes
```bash
make apply
```

## Linting and Security Checks

### Run Checkov
[Checkov](https://www.checkov.io/) is used for static analysis and security scanning of Terraform code.

1. Install Checkov:
   ```bash
   pip install checkov
   ```

2. Run Checkov:
   ```bash
   checkov -d .
   ```

## CI/CD Pipeline
A GitHub Actions workflow (`.github/workflows/ci-cd.yml`) is included to automate the following steps:
- Terraform initialization, validation, and linting
- Plan and apply stages for deployment

### Triggering the Workflow
The pipeline runs automatically on:
- commits to feature branches (`feat/`, `feature/`) or `main` branch
- deployment step runs only on main branch