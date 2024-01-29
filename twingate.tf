resource "twingate_resource" "this" {
  for_each = var.twingate_resources

  name              = each.value.name
  address           = each.value.address
  remote_network_id = coalesce(each.value.network_id, var.twingate_network_id)

  protocols {
    allow_icmp = each.value.protocols.allow_icmp
    tcp {
      policy = each.value.protocols.tcp_policy
      ports  = each.value.protocols.tcp_ports
    }
    udp {
      policy = each.value.protocols.udp_policy
      ports  = each.value.protocols.udp_ports
    }
  }

  access {
    group_ids           = each.value.group_ids
    service_account_ids = each.value.service_account_ids
  }
}
