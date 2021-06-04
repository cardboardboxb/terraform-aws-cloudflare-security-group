AWS CloudFlare security group Terraform module
==============================================

Terraform module that populates a security group with cloudflare ip ranges and keeps it updated daily.

The following resources are created:

* A lambda function that keeps your security group's ingress rules updated with published cloudflare ip ranges.
* A cloudwatch event rule with a schedule to trigger the lambda daily

Prerequisites
-----
* aws is [no longer supporting vendored version requests in botocore](https://aws.amazon.com/blogs/developer/removing-the-vendored-version-of-requests-from-botocore/)
* A lambda layer with requests installed (pip install --target . requests) must be provided

Ways to provide the lambda layer
-----
* if you are running terraform locally [it is possible to build a lambda layer within terraform via local-exec](https://medium.com/craftsmenltd/automate-python-libraries-deployment-at-aws-lambda-layer-from-pipfile-with-terraform-d28de0eb765f)
* terraform cloud however [does not allow for remote workspace installation via elevated pip](https://www.terraform.io/docs/cloud/run/install-software.html#installing-additional-tools)
  * step-by-step [guide to making an uploading a simple lambda layer](https://medium.com/the-cloud-architect/getting-started-with-aws-lambda-layers-for-python-6e10b1f9a5d)

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
| `layers` | `list(string)` | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. This layer must have requests installed. (pip install --target . requests) | - | Yes |
| `enabled` | `bool` | Whether to do anything at all, useful if cloudflare is not needed on all environments. | true | No |
| `enabled_egress_http` | `bool` | Whether to assign egress on port 80 tcp. | true | No |
| `enabled_egress_https` | `bool` | Whether to assign egress on port 443 tcp. | true | No |
| `schedule_expression` | `string` | The cloudwatch schedule expression used to run the updater lambda.  | cron(0 20 * * ? *) | No |
