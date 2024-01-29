# EKS:  Service AWS Resources

This module provides a means to provision common AWS resources required for numerous Kubernetes deployments (i.e. IAM Role for Service Account, SecretsManager Secret).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version  |
| ------------------------------------------------------------------------- | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | ~> 5.0   |

## Providers

| Name                                              | Version |
| ------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                          | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     | resource    |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                    | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)     | data source |

## Inputs

| Name                                                                     | Description                                                                                                                   | Type                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_eks"></a> [eks](#input\_eks)                              | The AWS account ID for the account that manages AWS user or service access                                                    | <pre>object({<br>    account_id           = optional(string, null)<br>    namespace            = optional(string, "default")<br>    oidc_issuer_url      = string<br>    service_account_name = optional(string, null)<br>  })</pre>                                                                                                    | n/a     |   yes    |
| <a name="input_environment"></a> [environment](#input\_environment)      | A naming object for the environment to provide both the environment's name and abbrevation for tagging and reporting purposes | <pre>object({<br>    name         = string<br>    abbreviation = string<br>  })</pre>                                                                                                                                                                                                                                                   | `null`  |    no    |
| <a name="input_iam_policies"></a> [iam\_policies](#input\_iam\_policies) | A collection of IAM policy ARNs to be additionally attached to the created IAM Role                                           | `list(string)`                                                                                                                                                                                                                                                                                                                          | `[]`    |    no    |
| <a name="input_naming"></a> [naming](#input\_naming)                     | A naming object to provide the display name of the service from the service catalog, and optionally also a resource name      | <pre>object({<br>    display  = string<br>    resource = optional(string, null)<br>  })</pre>                                                                                                                                                                                                                                           | n/a     |   yes    |
| <a name="input_tagging"></a> [tagging](#input\_tagging)                  | A collection of tags as key-value pairs to be applied to all applicable provisioned resources                                 | <pre>object({<br>    additional_tags = optional(map(any), {})<br>    network         = optional(string, null)<br>    organization    = string<br>    owner           = string<br>    service_name    = optional(string, null)<br>    service_pattern = optional(string, "EKS Deployment")<br>    tag_key_prefix  = string<br>  })</pre> | n/a     |   yes    |

## Outputs

| Name                                                                                                 | Description                               |
| ---------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn)                                       | The ARN of the IAM Role                   |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name)                                    | The Name attribute of the IAM Role        |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | The name of the Kubernetes ServiceAccount |
<!-- END_TF_DOCS -->