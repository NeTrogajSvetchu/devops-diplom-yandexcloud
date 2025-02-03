data "yandex_compute_image" "ubuntu-master" {
  family = var.os_image_master
}


resource "yandex_compute_instance" "master" {
  name        = "${var.yandex_compute_instance_master[0].vm_name}"
  platform_id = var.yandex_compute_instance_master[0].platform_id
  allow_stopping_for_update = true
  count = var.yandex_compute_instance_master[0].count_vms
  zone = var.zone-a
  resources {
    cores         = var.yandex_compute_instance_master[0].cores
    memory        = var.yandex_compute_instance_master[0].memory
    core_fraction = var.yandex_compute_instance_master[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-master.image_id
      type     = var.boot_disk_master[0].type
      size     = var.boot_disk_master[0].size
    }
  }

  metadata = {
    ssh-keys            = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.diplom-subnet-a.id
    nat       = true
  }
  scheduling_policy {
    preemptible = true
  }
}