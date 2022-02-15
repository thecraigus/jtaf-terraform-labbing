terraform {
  required_providers {
    junos-vsrx = {
      source  = "juniper/providers/junos-vsrx"
      version = "1.1"
    }
  }
}

provider "junos-vsrx" {
  host     = "192.168.137.55"
  port     = 830
  username = "craig"
  password = "Telecaster1!"
  sshkey   = ""
}

provider "junos-vsrx" {
  alias    = "backbone"
  host     = "192.168.137.56"
  port     = 830
  username = "craig"
  password = "Telecaster1!"
  sshkey   = ""
}

module "vsrx_1" {
  source = "./vsrx_1"

  providers = { junos-vsrx = junos-vsrx }

  depends_on = [junos-vsrx_destroycommit.commit-main]
}

module "vsrx_2" {
  source = "./vsrx_2"

  providers = { junos-vsrx = junos-vsrx.backbone }

  depends_on = [junos-vsrx_destroycommit.commit-main]
}

resource "junos-vsrx_commit" "commit-main" {
  resource_name = "commit"
  depends_on    = [module.vsrx_1]
}

resource "junos-vsrx_commit" "commit-main-backbone" {
  resource_name = "commit"
  provider      = junos-vsrx.backbone
  depends_on    = [module.vsrx_2]
}

resource "junos-vsrx_destroycommit" "commit-main" {
  resource_name = "destroycommit"
}

output "srx2-values" {
  value = module.vsrx_2.srx2-values

}

output "srx1-values" {
  value = module.vsrx_1.srx1-values

}
