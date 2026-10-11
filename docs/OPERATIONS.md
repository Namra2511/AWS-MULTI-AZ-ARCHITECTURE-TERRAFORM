# Operations and validation

## Before running anything

This repository is an **infrastructure example**, not a guarantee of a production-ready deployment. It creates billable AWS resources. Review a plan and estimate costs before applying.

The root S3 backend is configured for an existing bucket named `namra-terraform-state` and state key `production/terraform.tfstate`. **Do not change the backend or migrate existing state without first confirming ownership and making a recoverable backup.** For a separate deployment, use a different backend bucket/key and workspace or a separate account.

## Local static checks

Install Terraform >= 1.10 and run:

```bash
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
```

These commands do not create infrastructure. Validation is not a substitute for `terraform plan`, integration tests, or an actual deployment.

## Deployment review

1. Confirm AWS account and identity with `aws sts get-caller-identity`.
2. Confirm the state bucket exists, is private, versioned, encrypted, and that the operator has access to both state and the `.tflock` object.
3. Check the region, Availability Zones, AMI selection, subnet CIDRs, and desired ASG capacity.
4. Review `terraform plan` carefully, especially any **replacement** of instances, security groups, or launch templates.
5. Apply only after explicit approval and a cost review.

## Design limitations

- **Single NAT Gateway:** private subnets in all AZs depend on one NAT gateway in the first public subnet. This reduces cost but introduces a cross-AZ dependency and a single-AZ egress failure point.
- **HTTP-only ALB:** this demo has no TLS listener, certificate, custom domain, or HTTP-to-HTTPS redirect. Do not expose sensitive workloads over this configuration.
- **Scaling is not guaranteed instant:** target-tracking decisions depend on CloudWatch metrics, instance warmup, and actual load.
- **Session Manager:** instances have an SSM IAM role, but availability depends on agent health and network egress. No inbound SSH rule is configured.
- **AMI changes:** the default Canonical Ubuntu 22.04 AMI lookup chooses the latest matching image. New releases may cause launch-template updates on later plans. Pin `ami_id` for controlled releases.
- **Cost:** ALB, NAT gateway, EIPs, instances, data transfer, and logs may incur charges. This repo does not include a tested cost estimate.
- **Security:** an internet-facing HTTP listener is intended for demonstration only. Review organization-specific requirements for encryption in transit, WAF, logging, patching, and monitoring.

## Manual acceptance checks after an approved deployment

- Confirm all expected ALB targets are healthy.
- Request `http://$(terraform output -raw alb_dns_name)/` and verify nginx responds.
- Verify EC2 instances have no public IPs and accept HTTP only from the ALB security group.
- Verify private instances can reach required package repositories and Systems Manager.
- Review ASG activities after a controlled load test; capture evidence before claiming automatic scaling is demonstrated.
- Verify S3 state object and lock permissions without exposing state contents.

## Destruction

`terraform destroy` is destructive and may remove running resources. Confirm the correct AWS account, state key, and plan first. The separately created S3 backend bucket is not managed by this Terraform configuration.
