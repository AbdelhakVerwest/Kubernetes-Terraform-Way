#####################################################################################
# Output
#####################################################################################
output "Kubernetes_API_Public_IP" {
  value = "${azurerm_public_ip.PublicIP-FrontEndKubernetes.ip_address}"
}
output "Kubernetes_API_FQDN" {
  value = "${azurerm_public_ip.PublicIP-FrontEndKubernetes.fqdn}"
}
output "Worker_VM_Public_IP" {
  value = "${azurerm_public_ip.PublicIP-WorkerIP.*.ip_address}"
}
output "Controller_VM_Public_IP" {
  value = "${azurerm_public_ip.PublicIP-ControllerIP.*.ip_address}"
}
output "Worker_VM_Private_IP" {
  value = "${azurerm_network_interface.WorkerNIC.*.private_ip_address}"
}
output "Controller_VM_Private_IP" {
  value = "${azurerm_network_interface.ControllerNIC.*.private_ip_address}"
}
output "Worker_Names" {
  value = "${azurerm_virtual_machine.WorkerVM.*.name}"
}
output "Controller_Names" {
  value = "${azurerm_virtual_machine.ControllerVM.*.name}"
}
output "VMS_Password" {
  value = "${azurerm_key_vault_secret.kubesecret.value}"
}

