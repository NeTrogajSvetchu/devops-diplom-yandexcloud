
variable "os_image_master" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "yandex_compute_instance_master" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    count_vms = number
    platform_id = string
  }))

  default = [{
      vm_name = "master"
      cores         = 2
      memory        = 4
      core_fraction = 5
      count_vms = 1
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_master" {
  type        = list(object({
    size = number
    type = string
    }))
    default = [ {
    size = 10
    type = "network-hdd"
  }]
}
