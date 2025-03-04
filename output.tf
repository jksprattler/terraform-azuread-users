output "domain_name" {
  value = var.domain_name
}

output "users" {
  value = var.users
}

output "object_id" {
  value = { for user in azuread_user.this : user.mail_nickname => user.object_id }
}
