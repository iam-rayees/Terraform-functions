locals {
  Owner      = "Rayeez"
  TeamDL     = "mohd1234@gmail.com"
  costcenter = "HYD9090"
}


locals {
  all_instance_ids = concat(
    aws_instance.public_instances[*].id,
    aws_instance.private_instances[*].id
  )
}
