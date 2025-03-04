# Azure AD / Entra ID Users Terraform Module

Terraform module that manages cloud-based Azure AD / Entra ID user accounts

Inspired by the HashiCorp tutorial ["Manage Microsoft Entra ID users and groups"](https://developer.hashicorp.com/terraform/tutorials/it-saas/entra-id)

## Description

This Terraform module allows you to manage Azure AD / Entra ID user accounts using a CSV file. The module reads user data from the CSV file and creates or updates user accounts in Entra ID based on the provided attributes. It supports setting various user attributes, including account status, password policies, and contact information.

## User Data (users.csv)

The module requires a CSV file named `users.csv` to define the users to be created and their associated attributes. You can find a template `users.csv` file in the root directory of this repository containing the required headers and an example user. Additional user attributes can be set as seen in the [Inputs](#inputs) section below. Reference the [Resources](#resources) section for links to the provider docs with further details.

To use the template:

1. Copy the `users.csv` file to the same directory as your main Terraform configuration file.
2. Modify the file to include your own user data.
3. Ensure that the file is saved in UTF-8 encoding.

## User Generation

The `user_principal_name` is generated using the `mail_nickname` CSV input user values and the `domain_name` module value.

The `display_name` is generated using the `first_name` and `last_name` CSV input user values.

All users will be provisioned with a user principal name, or username, that follows the format: `mail_nickname@domain_name`

For example, user Michael Brown would have the following user principal name generated: `mbrown@jennasrunbooks.com`

## Password Generation

The module auto-generates temporary passwords for new users based on the following pattern: `<lowercase_lastname><lowercase_first_letter_of_firstname><length_of_firstname>!@#$`

For example, user Michael Brown would have the following password generated: `brownm7!@#$`

All users will be provisioned a temporary password that follows this format to be used upon initial login.

Upon initial authentication with the auto-generated temp `password` and `mail_nickname@domain_name` user principal name, the user will be forced to change their password.

## Example Usage

```terraform
locals {
  users = csvdecode(file("${path.module}/users.csv"))
}

module "user_setup" {
  source                       = "../"
  domain_name                  = "jennasrunbooks.com"
  users                        = local.users
  global_force_password_change = true
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_user.this](https://registry.terraform.io/providers/hashicorp/azuread/3.1.0/docs/resources/user) | resource |
| [azuread_domains.aad_domains](https://registry.terraform.io/providers/hashicorp/azuread/3.1.0/docs/data-sources/domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to use for managing the Azure AD / Entra ID users | `string` | n/a | yes |
| <a name="input_global_account_enabled"></a> [global\_account\_enabled](#input\_global\_account\_enabled) | (Optional) Whether or not the account should be enabled. Defaults to true. Applies globally to all users. | `bool` | `true` | no |
| <a name="input_global_disable_strong_password"></a> [global\_disable\_strong\_password](#input\_global\_disable\_strong\_password) | (Optional) Whether the user is forced to change the password during the next sign-in. Only takes effect when also changing the password. Defaults to false.  Applies globally to all users. | `bool` | `false` | no |
| <a name="input_global_force_password_change"></a> [global\_force\_password\_change](#input\_global\_force\_password\_change) | (Optional) Whether the user must change their password on next login. Defaults to false. Applies globally to all users. | `bool` | `false` | no |
| <a name="input_global_show_in_address_list"></a> [global\_show\_in\_address\_list](#input\_global\_show\_in\_address\_list) | (Optional) Whether or not the Outlook global address list should include this user. Defaults to true. Applies globally to all users. | `bool` | `true` | no |
| <a name="input_users"></a> [users](#input\_users) | Values assigned to Entra ID users managed in the local csv file | <pre>list(object({<br/>    first_name                 = string<br/>    last_name                  = string<br/>    mail_nickname              = string<br/>    account_enabled            = optional(bool)<br/>    age_group                  = optional(string)<br/>    business_phones            = optional(list(string))<br/>    company_name               = optional(string)<br/>    consent_provided_for_minor = optional(string)<br/>    cost_center                = optional(string)<br/>    country                    = optional(string)<br/>    department                 = optional(string)<br/>    disable_strong_password    = optional(bool)<br/>    division                   = optional(string)<br/>    employee_hire_date         = optional(string)<br/>    employee_id                = optional(string)<br/>    employee_type              = optional(string)<br/>    fax_number                 = optional(string)<br/>    force_password_change      = optional(bool)<br/>    given_name                 = optional(string)<br/>    job_title                  = optional(string)<br/>    mail                       = optional(string)<br/>    manager_id                 = optional(string)<br/>    mobile_phone               = optional(string)<br/>    office_location            = optional(string)<br/>    onpremises_immutable_id    = optional(string)<br/>    other_mails                = optional(list(string))<br/>    postal_code                = optional(string)<br/>    preferred_language         = optional(string)<br/>    show_in_address_list       = optional(bool)<br/>    state                      = optional(string)<br/>    street_address             = optional(string)<br/>    surname                    = optional(string)<br/>    usage_location             = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | n/a |
| <a name="output_users"></a> [users](#output\_users) | n/a |
<!-- END_TF_DOCS -->

## License

This project is licensed under the Mozilla Public License 2.0 - see the [LICENSE](LICENSE) file for details.
