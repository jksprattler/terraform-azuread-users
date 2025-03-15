data "azuread_domains" "aad_domains" {}

resource "random_password" "this" {
  for_each = var.password_generate_random ? { for user in var.users : user.mail_nickname => user } : {}
  length   = 32
  special  = true
  lower    = true
  upper    = true
  numeric  = true
}

resource "azuread_user" "this" {
  for_each = { for user in var.users : user.mail_nickname => user }
  user_principal_name = format(
    "%s@%s",
    lower(each.value.mail_nickname),
    var.domain_name
  )

  password = var.password_generate_random ? random_password.this[each.key].result : format(
    "%s%s%s!@#$",
    lower(each.value.last_name),
    substr(lower(each.value.first_name), 0, 1),
    length(each.value.first_name)
  )
  display_name = "${each.value.first_name} ${each.value.last_name}"

  # Conditionals for setting optional global values on booleans
  account_enabled         = lookup(each.value, "account_enabled", null) != null ? lookup(each.value, "account_enabled", null) : var.global_account_enabled
  disable_strong_password = lookup(each.value, "disable_strong_password", null) != null ? lookup(each.value, "disable_strong_password", null) : var.global_disable_strong_password
  force_password_change   = lookup(each.value, "force_password_change", null) != null ? lookup(each.value, "force_password_change", null) : var.global_force_password_change
  show_in_address_list    = lookup(each.value, "show_in_address_list", null) != null ? lookup(each.value, "show_in_address_list", null) : var.global_show_in_address_list

  age_group                  = lookup(each.value, "age_group", null)
  business_phones            = lookup(each.value, "business_phones", null)
  company_name               = lookup(each.value, "company_name", null)
  consent_provided_for_minor = lookup(each.value, "consent_provided_for_minor", null)
  cost_center                = lookup(each.value, "cost_center", null)
  country                    = lookup(each.value, "country", null)
  department                 = lookup(each.value, "department", null)
  division                   = lookup(each.value, "division", null)
  employee_hire_date         = lookup(each.value, "employee_hire_date", null)
  employee_id                = lookup(each.value, "employee_id", null)
  employee_type              = lookup(each.value, "employee_type", null)
  fax_number                 = lookup(each.value, "fax_number", null)
  given_name                 = lookup(each.value, "given_name", null)
  job_title                  = lookup(each.value, "job_title", null)
  mail                       = lookup(each.value, "mail", null)
  manager_id                 = lookup(each.value, "manager_id", null)
  mobile_phone               = lookup(each.value, "mobile_phone", null)
  office_location            = lookup(each.value, "office_location", null)
  onpremises_immutable_id    = lookup(each.value, "onpremises_immutable_id", null)
  other_mails                = lookup(each.value, "other_mails", null)
  postal_code                = lookup(each.value, "postal_code", null)
  preferred_language         = lookup(each.value, "preferred_language", null)
  state                      = lookup(each.value, "state", null)
  street_address             = lookup(each.value, "street_address", null)
  surname                    = lookup(each.value, "surname", null)
  usage_location             = lookup(each.value, "usage_location", null)

  # Ignore changes to the auto-generated tmp password in order to integrate terraform mgmt
  # with existing users without resetting passwords
  lifecycle {
    ignore_changes = [password]
  }
}
