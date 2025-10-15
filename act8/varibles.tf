# Variables for AWS configuration and SSH key path
variable "public_key" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/ec2.pub"
}