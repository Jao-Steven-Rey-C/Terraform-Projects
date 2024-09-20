output "all_info" {
  value = {
    #Functions
    ex1 = startswith(local.name, "John") //Case sensitve. Returns bool.
    ex2 = pow(local.age, 2)
    ex3 = yamldecode(file("${path.module}/users.yaml")).users[*].name
    ex4 = jsonencode(local.my_object)
    ex5 = signum(local.my_object.key1)
  }
}
