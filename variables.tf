variable "resgrp-vnets" {
 default = "RG-vnets"
 sensitive = false
}
variable "loc-vnets" {
  default = "westus"
  sensitive = false
}
variable "resgrp-forti" {
  default = "RG-fortinet"
  sensitive = false
}
variable "hub-vnet-111" {
default = "neida"
#  type = string
#  default = "fuckit"
}
variable "hub-vnet-222" {
default = "neia"
#  type = string
#  default = "fuckit"
}
variable "hub-vnet-rg" {
default = "ndfeia"
#  type = string
#  default = "fuckit"
}
variable "fgt-priv-ip" {
default = "12.1.23.3"
#  type = string
#  default = "fuckit"
}