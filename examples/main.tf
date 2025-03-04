locals {
  users = csvdecode(file("${path.module}/users.csv"))
}

module "user_setup" {
  source                       = "../"
  domain_name                  = "jennasrunbooks.com"
  users                        = local.users
  global_force_password_change = true
}
