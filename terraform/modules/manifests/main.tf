resource "local_file" "manifest" {
  content  = var.content
  filename = "${var.path}/${var.name}.yaml"
}

variable "content" {
  type = string
}

variable "name" {
  type = string
}

variable "path" {
  type = string
}
