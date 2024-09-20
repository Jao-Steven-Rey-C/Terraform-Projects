locals {
  //To use splat exp: <variable> = var.<existing list>[*].<object within list>. [*] means all.
  splat_firstnames = var.objects_list[*].firstname
  splat_roles      = values(local.users_map2)[*].roles //It is unadvisable to use splat expressions for maps.
}