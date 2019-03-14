resource "azurerm_managed_disk" "ControllerManagedDisk" {
    count                   = 3
    name                    = "Controller-${count.index + 1}-Datadisk"
    location                = "${var.AzureRegion}"
    resource_group_name     = "${var.RGName}"
    storage_account_type    = "Standard_LRS"
    create_option           = "Empty"
    disk_size_gb            = "127"
    tags {
        environment = "${var.TagEnvironment}"
        usage       = "${var.TagUsage}"
    }
}

# Managed disks for Web DB Backend VMs
resource "azurerm_managed_disk" "WorkerManagedDisk" {

    count                   = 3
    name                    = "Worker-${count.index + 1}-Datadisk"
    location                = "${var.AzureRegion}"
    resource_group_name     = "${var.RGName}"
    storage_account_type    = "Standard_LRS"
    create_option           = "Empty"
    disk_size_gb            = "127"

    tags {
    environment = "${var.TagEnvironment}"
    usage       = "${var.TagUsage}"
  }
    
}