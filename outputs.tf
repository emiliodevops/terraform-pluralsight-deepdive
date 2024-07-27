output "VM_Public_IP" {
  value = module.virtual_machine.public_ips["private-main_ip_config"].ip_address
}         