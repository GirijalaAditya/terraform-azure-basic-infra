locals {
  business_division = var.business_division
  environment       = var.environment
  prefix            = "${var.business_division}-${var.environment}"
  common_tags = {
    "Business Division" = local.business_division,
    "Environment"       = local.environment
  }
}