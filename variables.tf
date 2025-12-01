variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

# Network part 

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_address" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}
# Storage part

variable "storage_accout_name" {
  type = string
}

variable "fileshare_name" {
  type = string
}

# App service

variable "service_plan_name" {
  type = string
}

variable "webapp_name" {
  type = string
}

