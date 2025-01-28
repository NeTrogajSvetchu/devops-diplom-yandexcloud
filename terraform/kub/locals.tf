locals {
  ssh-keys = fileexists("/ssh_key/id_ed25519.pub") ? file("/ssh_key/id_ed25519.pub") : var.ssh_public_key
  ssh-private-keys = fileexists("/ssh_key/id_ed25519") ? file("/ssh_key/id_ed25519") : var.ssh_private_key
}