resource "digitalocean_droplet" "eve-ng" {
    image = "ubuntu-16-04-x64"
    name = "eve-ng.loganross.us"
    region = "nyc3"
    size = "512mb"
    private_networking = false
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
}
resource "digitalocean_domain" "eve-ng" {
  name       = "eve-ng.loganross.us"
  ip_address = "${digitalocean_droplet.eve-ng.ipv4_address}"
}
resource "digitalocean_project" "eve-ng" {
  name        = "eve-ng"
  description = "Networking Lab - created with Terraform"
  purpose     = "Web Application"
  environment = "Development"
  resources   = [
    "${digitalocean_droplet.eve-ng.urn}",
    "${digitalocean_domain.eve-ng.urn}"
    ]
}
