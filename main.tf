module "application" {
  source                = "app.terraform.io/ptonini-org/application/azuread"
  version               = "~> 1.0.0"
  count                 = var.application_client_id == null ? 1 : 0
  display_name          = var.name
  federated_credentials = var.federated_credentials
}

resource "azuread_service_principal" "this" {
  client_id                    = coalesce(one(module.application[*].this.client_id), var.application_client_id)
  alternative_names            = var.alternative_names
  notification_email_addresses = var.notification_email_addresses
  owners                       = var.owners
}

resource "azuread_service_principal_password" "this" {
  count                = var.create_password ? 1 : 0
  service_principal_id = azuread_service_principal.this.id
}

resource "azuread_group_member" "this" {
  for_each         = var.group_memberships
  group_object_id  = each.value
  member_object_id = azuread_service_principal.this.object_id
}

resource "azurerm_role_assignment" "this" {
  for_each             = var.role_assignments
  principal_id         = azuread_service_principal.this.object_id
  role_definition_name = coalesce(each.value.role_definition_name, each.key)
  scope                = each.value.scope
}
