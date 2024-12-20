locals {
  policies = { # is a map
    # Values are obtained from the policy names in the AWS console. This is not good practice... for some reason.
    admin     = ["AdministratorAccess"]
    developer = ["AmazonVPCFullAccess", "AmazonEC2FullAccess", "AmazonRDSFullAccess"]
    auditor   = ["SecurityAudit"]
    readonly  = ["ReadOnlyAccess"]
  }

  # The purpose of this is to easily be able to call both, the roles (key) and the policies (values). Basically converting the "policies" map to a list.
  list_of_roles_policies = flatten([          # Flatten simplifies a list by removing lists within lists (ex: flatten([["a"], ["b"]]) becomes ["a", "b"].)
    for pen, pineapples in local.policies : [ # Uses for loop to iterate over the map, "local.policies" with "pen" as the keys and "pineapples" as the values
      for pineapple in pineapples : {         # Uses for loop to list down information for every value within the map in this fashion:
        job   = pen                           # job = the keys
        rules = pineapple                     # rules = the values
      }
    ]
  ])
}

/*
1. This project iterates over existing roles and then creates a different role policy for each role.
2. For each role policy, (inside identifiers under "aws_iam_policy_document" data source), it must only include their respective users.
   (e.g., readonly only for Hawk_Tuah_Girl).
*/

data "aws_caller_identity" "current" {} # Your account's current identity.

# Generates an IAM policy document in JSON format for use with resources that expect policy documents
data "aws_iam_policy_document" "roles_documents" {
  for_each = toset(keys(local.policies))
  statement {
    actions = ["sts:AssumeRole"] # "sts:AssumeRole" means that it allows one to assume a role when one comes by the secure token service.

    principals { # This determines who can assume the action.
      type = "AWS"
      identifiers = [
        for user in keys(local.users_from_map) :                                   # Iterates over the list of keys from the map, "local.users_from_map"
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}" # then returns an ARN which calls the most recent account ID and all the keys.
        if contains(local.users_from_map[user], each.value)                        # Checks the map, local.users_from_map and sees if each item contains its respective roles (values).
      ]                                                                            # Must not be left empty. Must contain user's ARN(s).
    }
  }
}

data "aws_iam_policy" "policies" {
  for_each = toset(local.list_of_roles_policies[*].rules) # Gets the "policy" attribute from the list, local.list_of_roles_policies. Converts to set.
  arn      = "arn:aws:iam::aws:policy/${each.value}"      # and then accesses all of them which is what this data source needs... with a prefix.
}

# For the users' roles
resource "aws_iam_role" "roles" {
  for_each           = toset(keys(local.policies))                                   # Gets only the keys of the map, local.policies then converts it to set.
  name               = each.key                                                      # and then accesses all the keys which is what this resource needs to point to.
  assume_role_policy = data.aws_iam_policy_document.roles_documents[each.value].json # Must be a JSON file. For every role (key), will point to every respective policy (value).
}

# Connects the roles with the respective policies
resource "aws_iam_role_policy_attachment" "role_and_policy_attach" {
  count      = length(local.list_of_roles_policies) # Gets the length of the list, local.list_of_roles_policies.
  role       = aws_iam_role.roles[local.list_of_roles_policies[count.index].job].name
  policy_arn = data.aws_iam_policy.policies[local.list_of_roles_policies[count.index].rules].arn
}