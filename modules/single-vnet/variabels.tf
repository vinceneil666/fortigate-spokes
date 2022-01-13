variable "resource_group_name" {
 default = "vnets-rg"
}
variable "location" {
  default = "eastus"
  sensitive = false
}
variable "address_space-vnets" {
  default = "10.20.0.0/16"
}
variable "name-vnets" {
  default = "forgot-name"
}
variable "routetable" {
  type = bool
  default = false
}
variable "hub-vnet" {
  default = "false"
}
  variable "location_short" {
  default = "neu"
}
variable "hub-vnet-name" {
  default = "false"
}
variable "hub-vnet-rg" {
  default = "false"
}
variable "fgt-priv-ip" {
  default = "false"
}