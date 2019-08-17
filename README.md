# sandboc-db

```bash
## Sandbox prep command
./prep_backend.sh -a maintenance -b tk-infra-dev -r us-east-1 -s sandbox > terraform.tf
```

```bash
## Deploy command
terraform init
terraform plan -var-file=./config/sandbox.tfvars -out plan.out
terraform apply "plan.out"
```

