module "eks_service_account_role" {
  for_each = var.service_account_roles

  source  = "app.terraform.io/aedificans/IAM-Role-EKS-ServiceAccount/aws"
  version = "1.0.3"

  eks = {
    account_id           = data.aws_caller_identity.this.account_id
    namespace            = coalesce(each.value.namespace, var.namespace)
    oidc_issuer_url      = var.eks_oidc_issuer_url
    service_account_name = each.value.service_account_name
  }
  environment         = var.environment
  iam_policy_document = each.value.iam_policy_document
  iam_policies        = each.value.iam_policies
  naming = {
    display  = replace("${var.naming.display} ${title(coalesce(each.value.naming.display, each.key))}", "/[_-]/", " ")
    resource = (var.naming.resource == null ? null : lower(replace("${coalesce(var.naming.resource)}-${coalesce(each.value.naming.resource, each.key)}", "_", "-")))
  }
  tagging = var.tagging
}
