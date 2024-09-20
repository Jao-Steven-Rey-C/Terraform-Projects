locals {
  #Operators
  math       = 2 * 2         #Math operators: +, -, *, /, %, -<a number>
  equality   = 2 != 2        #Equality operators: ==, !=
  comparison = 2 < 1         #Comparison operators: <, >, <=, >=
  logical    = true || false #Logical operators: OR ||, AND &&*

  #Lists
  //How every 'for loop works: [for <every item> in <this variable list> : <do this>]
  farenheit             = [for temp in var.temperatures_celcius : (temp * 9 / 5) + 32] //"for" mean iterating over a list. Similar to Python.
  lucky_chinese_numbers = [for num in var.numbers_list : num if(num - 8) % 10 == 0]    //Displays item in list if the 'if' condition is met.
  firstnames            = [for person in var.objects_list : person.firstname]          //Finds the 'firstname' string within objects_list variable.

  fullnames = [
    for person in var.objects_list : "Engr. ${person.firstname} ${person.middlename} ${person.lastname}"
  ]

  #Maps
  farenheit_map             = { for key, value in var.temperatures_celcius_map : key => (value * 9 / 5) + 32 } //'key' and 'value' are temporary variables.
  lucky_chinese_numbers_map = { for key, value in var.numbers_map : key => value if(value - 8) % 10 == 0 }

  #Lists + Maps
  users_map = { for user_info in var.users : user_info.username => user_info.role... } //List to map

  users_map2 = {
    for username, roles in local.users_map : username => { roles = roles } //Adds 'roles' on top of roles
  }

  usernames_from_map = [for username, roles in local.users_map : username] //Map to list (gets list of usernames)
  # We can also use usernames_from_map = keys(local.users_map) instead of manually creating the list!
}