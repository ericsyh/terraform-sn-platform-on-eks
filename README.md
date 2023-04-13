# terraform-sn-platform-on-eks

## Introduction

This repo levarages [terraform](https://www.terraform.io/) to automate with below processes with a single terraform command: 
1. Provision an [EKS](https://aws.amazon.com/eks/) cluster
2. Configure the AKS cluster connection
3. Install the [vault-operator](https://github.com/banzaicloud/bank-vaults/tree/main/charts/vault-operator), [pulsar-operator](https://github.com/streamnative/charts/tree/master/charts/pulsar-operator) and [sn-platform](https://github.com/streamnative/charts/tree/master/charts/sn-platform) charts
4. Expose the StreamNative Console and Grafana with LoadBalancer

## Prerequisites

### AWS CLI

1. Install AWS CLI

```
brew install awscli
```

2. Configure profile credential with AWS SSO

```
aws configure sso
```

> **Note**
> 
> Because of the [sso-session](https://github.com/hashicorp/terraform-provider-aws/issues/28263) is not supported on [terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws). We need to configure the aws sso in the legacy format(without an SSO session) like this way below:
> ```
> aws configure sso
> SSO session name (Recommended):
> WARNING: Configuring using legacy format (e.g. without an SSO session).
> Consider re-running "configure sso" command and providing a session name.
> SSO start URL [None]:
> ```

After completing the profile configuration, you should ok to run with

```
aws s3 ls --profile <your-profile-name>

2022-08-20 15:45:47 your-bucket-xxx
2022-06-23 15:56:47 your-bucket-xxx
```

### Terraform CLI

1. Install Terraform CLI

```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## How to use

1. Clone this repo

```
git clone https://github.com/ericsyh/terraform-sn-platform-on-eks.git
cd terraform-sn-platform-on-eks
```

2. Input the `region` and `profile` in the `terraform.tfvars` file. 

3. Modify the `snp.yaml` to change the values configure you need. 

4. Run the terraform commands to initialize and execute: 

```
terraform init
terraform apply --auto-approve
```

5. Configure your EKS cluster to your local `kubectl`:

```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name) --profile $(terraform output -raw profile)
```

6. Cleanup your provision:

```
terraform destroy --auto-approve
```