# Terraform to be used with Openstack
```
source openstack file from OPENRC'em
fill values in main tf
terraform init ==> error
terraform --version ==> Terraform v0.13.5
terraform 0.13upgrade ==> OK
terraform --version  ==> Terraform v0.13.5

terraform plan -auto-approve
terraform apply -auto-approve
terraform destroy -auto-approve
```