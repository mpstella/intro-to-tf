variable "project" {
  type        = string
  description = "The name of the project"
}

variable "region" {
  type        = string
  description = "The region of the project resources"
}

variable "zone" {
  type        = string
  description = "The zone within the region"
}

locals {
  common_labels = {
    "env"         = "playpen",
    "provisioner" = "terraform",
  }
}
