# How to deploy
1. Adapt variables to your project 
   * Change the variables in terraform/terraform.tfvars as you want \
 Variables from this file are further referred to as <variable_name>
   * Change the bucket name in the **backend "gcs"** block in the terraform resource in terraform/provider.tf to \
 bucket-tfstate-<project_id>
2. Make a bucket for Terraform remote state and enable versioning
```commandline
gsutil mb -l eu gs://bucket-tfstate-<project_id>
gsutil versioning set on gs://bucket-tfstate-<project_id>
```
3. From the terraform directory
 ```commandline
terraform init
terraform plan -out plan.out
terraform apply plan.out 
```
4. Push the Docker container to Artifact Registry
```commandline
gcloud builds submit --region=<region> --tag <region>-docker.pkg.dev/<project_id>/<docker_repository>/<docker_image>
```
5. From the terraform directory
```commandline
terraform plan -out plan.out
terraform apply plan.out 
```
