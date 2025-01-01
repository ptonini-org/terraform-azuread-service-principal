variable "name" {}

variable "application_client_id" {
  default = null
}

variable "alternative_names" {
  type    = set(string)
  default = null
}

variable "notification_email_addresses" {
  type    = set(string)
  default = null
}

variable "owners" {
  type    = set(string)
  default = null
}

variable "create_password" {
  default  = false
  nullable = false
}

variable "federated_credentials" {
  type = map(object({
    display_name = optional(string)
    issuer       = string
    subject      = string
    audiences    = optional(set(string))
  }))
  default  = {}
  nullable = false
}

variable "role_assignments" {
  type = map(object({
    role_definition_name = optional(string)
    scope                = string
  }))
  default  = {}
  nullable = false
}

variable "group_memberships" {
  type     = set(string)
  default  = []
  nullable = false
}