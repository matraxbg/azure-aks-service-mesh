variable "location" {
  type = string
  default = "westeurope"
}

variable "dns_prefix" {
  type = string
  default = null
}

variable "environment" {
  type = string
  default = "development"
}