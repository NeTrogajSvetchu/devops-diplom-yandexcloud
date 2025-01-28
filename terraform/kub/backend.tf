terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "storage-website-test"
    region = "ru-central1"
    key = "storage-website-test/terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
  }
}

