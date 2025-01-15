variable "create_iam_role" {
  type    = bool
  default = true
}

variable "role_name" {
  type    = string
  default = null
}

variable "assume_role_policy" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}

variable "managed_iam_policies_to_attach" {
  type    = list(any)
  default = []
}

variable "inline_policies_to_attach" {
  type    = any
  default = {}
}
