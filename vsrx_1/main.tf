terraform {
  required_providers {
    junos-vsrx = {
      source  = "juniper/providers/junos-vsrx"
      version = "1.1"
    }
  }
}

// To test Terraform's ability to remove a single resource,
// comment out one resource below and use `terraform taint` on the commit
// resource so that an apply also applies the commit.

resource "junos-vsrx_SecurityAddress__BookAddressIp__Prefix" "vsrx_7" {
  resource_name = "vsrx_7"
  name          = "global"
  name__1       = "fw-1-craig4"
  ip__prefix    = "11.0.48.0/24"
}

# resource "junos-vsrx_commit" "commit1" {
#   resource_name = "commit"
#   depends_on = [
#     junos-vsrx_SecurityAddress__BookAddressIp__Prefix.vsrx_7,
#   ]
# }

output "srx1-values" {
  value = junos-vsrx_SecurityAddress__BookAddressIp__Prefix.vsrx_7.ip__prefix

}

