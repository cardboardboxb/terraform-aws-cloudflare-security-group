variable "security_group_id" {
  description = "An existing security group to populate with cloudflare ips as ingress rules."
  type        = string
}
variable "enabled" {
  description = "Whether to do anything at all, useful if cloudflare is not needed on all environments."
  type        = bool
  default     = true
}
variable "enabled_egress_http" {
  description = "Whether to assign egress on port 80 tcp."
  type        = bool
  default     = true
}
variable "enabled_egress_https" {
  description = "Whether to assign egress on port 443 tcp."
  type        = bool
  default     = true
}
variable "schedule_expression" {
  description = "The cloudwatch schedule expression used to run the updater lambda."
  type        = string
  default     = "cron(0 20 * * ? *)"
}
