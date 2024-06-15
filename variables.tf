
variable "admin_username" {
  type      = string
  sensitive = true
  default = "devadmin"
}


variable "admin_password" {
  type      = string
  sensitive = true
  default = "P@ssw0rd4321!"
}

 
variable "admin_ssh" {
  type      = string
  sensitive = true
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCH6OOpWA1kwZA/gCywD06cnKNWNTiwuZZEfz5FzUWvkZRZS5xIMFC64YdIo2Jkaw2MfMrLFZ25vWsCNdCvoyyXcCOoMxNA1HmCjuymMottcFJDDbvG8lX0sjoKg8KWbeeMh+bgdlHIsWCYlR+P17e+AZ6+q2eluLn8agT6+vA6m2poXMiPONlhvf58WNhApsTu8qpgueYzbOPeFZC99FQSQCXTWnQmjMFudk5VxtJuxvNb/gp9ZGde1GEE3DaHuFV85Wo6u+xmLnBHvEBI+huhZGSEA8sS8G2D3rXGwHLAE8D+VhnjYJUwL8OgDJ9bCL2U5ygW4SZSTG0nl9gOA7lsutyfg6N3vUa0JepTHlTJYcI/goQQD0uwAkaS73kgv0KM1o3yJlf5OME5DFZSX4l5PHD4zp4QmkN6OyqQY9NwOs448d9WKbXs+9e8Adm+Ys58Z76w7pmdyKk9E4QOs67BStJ85hrqVr9M7yLMqTvYw/tuUZ7Bs5sAIf+Km2BW1lUVaQA4ENq6YeknKyusfjDD0EenQIXF42mBkI9HP1GxQf0R4ZBgr33PIPS6u/sMPu2bqGYeoxvmASeBKTk19yNjQi9SVEV4TpFrniZyCFeq6tnuP+dmAYfc8feYQM9GivCOIu7tlspY2XSnbxO0wDWjgd0BwSyXn5srA1GreN729Q== rsa-key-20240608"
}
