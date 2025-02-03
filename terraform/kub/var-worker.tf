variable "os_image_worker" {
  type    = string
  default = "ubuntu-2004-lts"
}


variable "worker_count" {
  type    = number
  default = 2
}

variable "worker_resources" {
  type = object({
    cpu         = number
    ram         = number
    disk        = number
    core_fraction = number
    platform_id = string
  })
  default = {
    cpu         = 4
    ram         = 8
    disk        = 10
    core_fraction = 10
    platform_id = "standard-v1"
  }
}


