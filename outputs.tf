output "secrets" {
  value = {
    for key, secret in module.secret : "${local._formatting.service_resource}-${key}" => {
      arn     = secret.arn
      name    = secret.name
      key_arn = secret.key_arn
    }
  }
  description = "A map of all K8s ServiceAccount IAM Role details"
}
output "service_accounts" {
  value       = { for key, role in module.eks_service_account_role : "${local._formatting.service_resource}-${key}" => role }
  description = "A map of all K8s ServiceAccount IAM Role details"
}


