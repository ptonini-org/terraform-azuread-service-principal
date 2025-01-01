output "this" {
  value = azuread_service_principal.this
}

output "client_id" {
  value = azuread_service_principal.this.client_id
}

output "object_id" {
  value = azuread_service_principal.this.object_id
}

output "password" {
  value = one(azuread_service_principal_password.this[*].value)
}