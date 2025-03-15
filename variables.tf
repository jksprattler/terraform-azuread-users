variable "password_generate_random" {
  type        = bool
  default     = true
  description = "Generates a random 32 character long, unused password stored to terraform state."
}

variable "users" {
  type = list(object({
    first_name                 = string
    last_name                  = string
    mail_nickname              = string
    account_enabled            = optional(bool)
    age_group                  = optional(string)
    business_phones            = optional(list(string))
    company_name               = optional(string)
    consent_provided_for_minor = optional(string)
    cost_center                = optional(string)
    country                    = optional(string)
    department                 = optional(string)
    disable_strong_password    = optional(bool)
    division                   = optional(string)
    employee_hire_date         = optional(string)
    employee_id                = optional(string)
    employee_type              = optional(string)
    fax_number                 = optional(string)
    force_password_change      = optional(bool)
    given_name                 = optional(string)
    job_title                  = optional(string)
    mail                       = optional(string)
    manager_id                 = optional(string)
    mobile_phone               = optional(string)
    office_location            = optional(string)
    onpremises_immutable_id    = optional(string)
    other_mails                = optional(list(string))
    postal_code                = optional(string)
    preferred_language         = optional(string)
    show_in_address_list       = optional(bool)
    state                      = optional(string)
    street_address             = optional(string)
    surname                    = optional(string)
    usage_location             = optional(string)
  }))
  description = "Values assigned to Entra ID users managed in the local csv file"
}

variable "global_account_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Whether or not the account should be enabled. Defaults to true. Applies globally to all users."
}

variable "global_disable_strong_password" {
  type        = bool
  default     = false
  description = "(Optional) Whether the user is forced to change the password during the next sign-in. Only takes effect when also changing the password. Defaults to false.  Applies globally to all users."
}

variable "global_force_password_change" {
  type        = bool
  default     = false
  description = "(Optional) Whether the user must change their password on next login. Defaults to false. Applies globally to all users."
}

variable "global_show_in_address_list" {
  type        = bool
  default     = true
  description = "(Optional) Whether or not the Outlook global address list should include this user. Defaults to true. Applies globally to all users."
}

variable "domain_name" {
  type        = string
  description = "The domain name to use for managing the Azure AD / Entra ID users"
}
