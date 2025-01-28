

resource "yandex_storage_bucket" "bucket" {
  bucket     = "storage-website-test"
  access_key = yandex_iam_service_account_static_access_key.terraform_service_account_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.terraform_service_account_key.secret_key

  anonymous_access_flags {
    read = false
    list = false
  }

  force_destroy = true

provisioner "local-exec" {
  command = "echo ${yandex_iam_service_account_static_access_key.terraform_service_account_key.access_key} > ../s3/access_key.tfvars"
}

provisioner "local-exec" {
  command = "echo ${yandex_iam_service_account_static_access_key.terraform_service_account_key.secret_key} >> ../s3/secret_key.tfvars"
}
}
