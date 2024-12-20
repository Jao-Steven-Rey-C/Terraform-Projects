output "all_info" {
  value = {
    users         = local.users_from_yaml
    passwords     = { for user, password in aws_iam_user_login_profile.passwords : user => password.password } # Accesses the user and password argument in the resource aws_iam_user_login_profile.passwords, then outputs user as key and password as value. Do not do this in real life.
    policies_list = local.list_of_roles_policies
    users_map     = local.users_from_map
    # understander_output =  # This line is used to visualize this project's multiple lengthy coding.
  }
}