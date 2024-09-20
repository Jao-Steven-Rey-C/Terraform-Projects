#Lists
variable "numbers_list" {
  type = list(number)
}

variable "temperatures_celcius" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname  = string
    middlename = string
    lastname   = string
  }))
}

#Maps
variable "temperatures_celcius_map" {
  type = map(number)
}

variable "numbers_map" {
  type = map(number)
}

#Lists + Maps
variable "users" { //List to map
  type = list(object({
    username = string
    role     = string
  }))
}

variable "Steven_Roles" {
  type = string
}