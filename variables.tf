variable "common_tags" {
  type = map(string)
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "ChunI.Lin"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

variable "location" {
  type    = string
  default = "Canada Central"
}