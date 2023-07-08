variable "vnet_name" {
  description = "Azure Virtual Network Name"
  type        = string
}

variable "vnet_address_space" {
  description = "Azure Virtual Network Address Space"
  type        = list(string)
}

variable "web_subnet_name" {
  description = "Web Subnet Name"
  type        = string
}

variable "web_subnet_address_space" {
  description = "Web Subnet Address Space"
  type        = list(string)
}

variable "app_subnet_name" {
  description = "Subnet Name"
  type        = string
}

variable "app_subnet_address_space" {
  description = "App Subnet Address Space"
  type        = list(string)
}

variable "db_subnet_name" {
  description = "DB Subnet Name"
  type        = string
}

variable "db_subnet_address_space" {
  description = "DB Subnet Address Space"
  type        = list(string)
}

variable "bastion_subnet_name" {
  description = "Bastion Subnet Name"
  type        = string
}

variable "bastion_subnet_address_space" {
  description = "Bastion Subnet Address Space"
  type        = list(string)
}