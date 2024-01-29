#==================#
# Naming & Tagging #
#==================#

variable "environment" {
  description = "A naming object for the environment to provide both the environment's name and abbrevation for tagging and reporting purposes"
  type = object({
    name         = string
    abbreviation = string
  })
  default = null

  validation {
    condition     = can(regex("^[a-zA-Z 0-9\\-]*$", var.environment.name)) || var.environment == null
    error_message = "The environment name must only contain alphanumeric characters, spaces, and hyphens"
  }
  validation {
    condition     = can(regex("^[a-z0-9\\-]*$", var.environment.abbreviation)) || var.environment == null
    error_message = "The environment abbreviation must be kebab case"
  }
}
variable "naming" {
  description = "A naming object to provide the display name of the service from the service catalog, and optionally also a resource name"
  type = object({
    display  = string
    resource = optional(string, null)
  })

  validation {
    condition     = can(regex("^[a-zA-Z 0-9\\-]*$", var.naming.display))
    error_message = "The service display name must only contain alphanumeric characters, spaces, and hyphens"
  }
  validation {
    condition     = can(regex("^[a-z0-9\\-]*$", var.naming.resource)) || var.naming.resource == null
    error_message = "If provided, the service resource name must be kebab case"
  }
}
variable "tagging" {
  description = "A collection of tags as key-value pairs to be applied to all applicable provisioned resources"
  type = object({
    additional_tags = optional(map(any), {})
    network         = optional(string, null)
    organization    = string
    owner           = string
    service_name    = optional(string, null)
    service_pattern = optional(string, "EKS Deployment")
    tag_key_prefix  = string
  })
}

#==================#
# Resource Configs #
#==================#

variable "eks_oidc_issuer_url" {
  description = "The EKS OIDC issuer URL"
  type        = string
}
variable "kms_key_arn" {
  description = "The EKS OIDC issuer URL"
  type        = string
  default     = null
}
variable "namespace" {
  description = "The EKS OIDC issuer URL"
  type        = string
  default     = "default"
}
variable "secrets" {
  description = "The AWS account ID for the account that manages AWS user or service access"
  type = map(object({
    description = string
    kms_key_arn = optional(string, null)
    naming = optional(object({
      display  = optional(string, null)
      resource = optional(string, null)
    }), {})
    namespace     = optional(string, null)
    secret_string = optional(string, null)
  }))
  default = {}
}
variable "service_account_roles" {
  description = "The AWS account ID for the account that manages AWS user or service access"
  type = map(object({
    naming = optional(object({
      display  = optional(string, null)
      resource = optional(string, null)
    }), {})
    iam_policy_document  = optional(string, null)
    iam_policies         = optional(list(string), [])
    namespace            = optional(string, null)
    service_account_name = optional(string, null)
  }))
  default = {}
}
variable "twingate_network_id" {
  description = "The Twingate network ID for the resources to be exposed"
  type        = string
  default     = null
}
variable "twingate_resources" {
  description = "A collection of IAM policy ARNs to be additionally attached to the created IAM Role"
  type = map(object({
    address    = string
    name       = string
    network_id = optional(string, null)
    protocols = optional(object({
      allow_icmp = optional(bool, true)
      tcp_policy = optional(string, "RESTRICTED")
      tcp_ports  = optional(list(string), ["80", "443"])
      udp_policy = optional(string, "DENY_ALL")
      udp_ports  = optional(list(string), null)
    }), {})
    group_ids           = list(string)
    service_account_ids = optional(list(string), null)
  }))
  default = {}
}
