variable "application_identity" {
  type        = string
  description = "The service account email to use for the cloud function"
}

variable "md_metadata" {
  type        = string
}

variable "envs" {
  type = any
}

variable "resource_group_name" {
  type        = string
}
