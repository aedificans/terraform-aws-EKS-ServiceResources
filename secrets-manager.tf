module "secret" {
  for_each = var.secrets

  source  = "app.terraform.io/aedificans/Base-SecretsManager-Secret/aws"
  version = "1.0.5"

  description = each.value.description
  environment = var.environment
  kms_key_arn = coalesce(each.value.kms_key_arn, var.kms_key_arn)
  naming = {
    display  = replace("${var.naming.display} ${title(coalesce(each.value.naming.display, each.key))}", "/[_-]/", " ")
    resource = lower(replace("eks/${coalesce(each.value.namespace, var.namespace)}/${coalesce(var.naming.resource, local._formatting.service_resource)}/${coalesce(each.value.naming.resource, each.key)}", "_", "-"))
  }
  secret_string = each.value.secret_string
  tagging       = var.tagging
}
