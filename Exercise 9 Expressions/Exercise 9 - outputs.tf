output "all_info" {
  value = {
    #Operators
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical

    #Lists
    farenheit             = local.farenheit
    lucky_chinese_numbers = local.lucky_chinese_numbers
    firstnames            = local.firstnames
    fullnames             = local.fullnames

    #Maps
    farenheit_map             = local.farenheit_map
    lucky_chinese_numbers_map = local.lucky_chinese_numbers_map

    #Lists + Maps
    users_map          = local.users_map //List to map
    users_map2         = local.users_map2
    Steven_roles       = local.users_map2[var.Steven_Roles].roles //Role of specific user
    usernames_from_map = local.usernames_from_map                 //Map to list

    #Splat Expressions
    splat_firstnames = local.splat_firstnames
    splat_roles      = local.splat_roles
  }
}