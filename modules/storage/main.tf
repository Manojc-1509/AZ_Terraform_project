resource "azurerm_storage_account" "storage_accout" {
  name                     = var.storage_accout_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_share" "share" {
  name               = var.fileshare_name
  storage_account_id = azurerm_storage_account.storage_accout.id
  quota              = 50
}

resource "azurerm_storage_share_file" "fileshare" {
  name              = "docker_image"
  storage_share_url = azurerm_storage_share.share.url
  source            = "${path.module}/uploads/docker_image.html"
}
