data "yandex_compute_image" "ubuntu-worker" {
  family = var.os_image_worker
}

resource "yandex_compute_instance" "worker" {
  depends_on = [yandex_compute_instance.master]
  count      = var.worker_count
  allow_stopping_for_update = true
  name          = "worker-${count.index + 1}"
  platform_id   = var.worker_resources.platform_id
  zone = var.zone-b
  resources {
    cores         = var.worker_resources.cpu
    memory        = var.worker_resources.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-worker.image_id
      size     = var.worker_resources.disk
    }
  }

  metadata = {
    ssh-keys           = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.diplom-subnet-b.id
    nat                = true
  }

  scheduling_policy {
    preemptible = true
  }
}