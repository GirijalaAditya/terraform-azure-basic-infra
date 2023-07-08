resource "random_string" "random_data" {
  length  = 8
  special = false
  upper   = false
  numeric = false
  lower   = true
}