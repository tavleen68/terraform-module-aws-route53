variable "create" {
  description = "Whether to create Route53 zone"
  type        = bool
  default     = true
}

variable "parent_domain" {
  description = "parent domain, same as parent zone"
  default = null
  type = string
}

variable "parent_zones" {
  description = "Map of Route53 zone parameters"
  type        = any
  default     = {}
}

variable "child_zones" {
  description = "Map of Route53 zone parameters"
  type        = any
  default     = {}
}

variable "private_zones" {
  description = "Map of Route53 zone parameters"
  type        = any
  default     = {}
}

variable "default_tags" {
  description = "Tags added to all zones. Will take precedence over tags from the 'zones' variable"
  type        = map(any)
  default     = {}
}
