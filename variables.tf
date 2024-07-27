variable "location" {
  type    = string
  default = "westus"
}

variable "use_for_each" {
  type    = bool
  default = true
}

variable "vm_adminusername" {
  type        = string
  description = "Admin User Name"
}
variable "vm_adminpsw" {
  type        = string
  description = "Admin User Name"
}
