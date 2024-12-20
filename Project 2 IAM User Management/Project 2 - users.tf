locals {
  # "Decode (this yaml file) and retrieve only the information under the "users" bracket."
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml")).users

  # In Terraform, it is easier to convert the yaml file to map than to decode it???
  users_from_map = { for role in local.users_from_yaml : role.username => role.roles } # Transforms the decoded yaml file from list to map. Add "..." to allow username duplication (not recommended).
  # flattened_users_from_map = { for user, role in local.users_from_map : user => flatten(role) } # Simply flattens the list, "role" (values) from the map, "users_from_map".
}

# Just the usernames
resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml[*].username) # Converts "local.users_from_yaml", which is a list, to a set. Accesses only ALL of the username part.
  name     = each.value
}

# For the users' passwords
resource "aws_iam_user_login_profile" "passwords" {
  for_each        = aws_iam_user.users # Iterates over the list of resources, "aws_iam_user.users"
  user            = each.value.name    # and then accesses the name which is what this resource needs to point to.
  password_length = 8

  lifecycle {
    # The purpose of ignoring these changes is so that when we decide to change password length, the ones already existing won't be changed and cause catastrophe.
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}