AWS CloudFlare security group Terraform module
==============================================

Terraform module that populates a security group with cloudflare ip ranges and keeps it updated daily.

The following resources are created:

* A lambda function that keeps your security group's ingress rules updated with published cloudflare ip ranges.
* A cloudwatch event rule with a schedule to trigger the lambda daily

Usage
-----

```hcl
module "cloudflare-ips" {
  source = "github.com/orzarchi/terraform-aws-cloudflare-security-group"

  security_group_id = aws_security_group.cloudflare.id
  enabled= var.use_cloudflare
}
```

Variables
--------
| Name | Type | Description | Default | Required |
|-----|:-----:|-----|:-----:|:-----:|
| `security_group_id` | `string` | An existing security group to populate with cloudflare ips as ingress rules. | - | Yes |
| `enabled` | `bool` | Whether to do anything at all, useful if cloudflare is not needed on all environments. | true | No |
| `enabled_egress_http` | `bool` | Whether to assign egress on port 80 tcp. | true | No |
| `enabled_egress_https` | `bool` | Whether to assign egress on port 443 tcp. | true | No |
| `schedule_expression` | `string` | The cloudwatch schedule expression used to run the updater lambda.  | cron(0 20 * * ? *) | No |
