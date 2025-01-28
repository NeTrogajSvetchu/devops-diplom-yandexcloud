resource "yandex_vpc_network" "diplom" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "diplom-subnet-a" {
  name           = var.subnet-a
  zone           = var.zone-a
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = var.cidr-a
}

resource "yandex_vpc_subnet" "diplom-subnet-b" {
  name           = var.subnet-b
  zone           = var.zone-b
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = var.cidr-b
}

