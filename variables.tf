variable "labels" {
  description = "Labels of the Role and RoleBinding object"
  type        = map(string)
  default     = {}
}

variable "members" {
  description = "Membership of this Role"
  type        = list(map(string))
}

variable "name" {
  description = "Name of the Role"
  type        = string
}

variable "namespace" {
  description = "Namespace of the Role"
  type        = string
}

variable "rules" {
  description = "Rules to assign for the Role"
  type = list(object({
    api_groups     = list(string)
    resources      = list(string)
    resource_names = list(string)
    verbs          = list(string)
  }))
}
