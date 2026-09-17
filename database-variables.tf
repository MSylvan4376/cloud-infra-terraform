variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "appuser"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]{0,15}$", var.db_username))
    error_message = "db_username must begin with a letter, contain only letters, numbers, or underscores, and be no more than 16 characters."
  }
}
